Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF5A62DF5F
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 16:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240601AbiKQPNF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 10:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbiKQPMf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 10:12:35 -0500
X-Greylist: delayed 918 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Nov 2022 07:09:09 PST
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E486769F8;
        Thu, 17 Nov 2022 07:09:08 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ovgGz-0004A8-3O; Thu, 17 Nov 2022 15:53:49 +0100
Date:   Thu, 17 Nov 2022 15:53:49 +0100
From:   Florian Westphal <fw@strlen.de>
To:     netfilter-devel@vger.kernel.org, bpf@vger.kernel.org
Subject: netfilter bpf-jit patchset: test results
Message-ID: <Y3ZK/RDJliIqAfQU@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

As promised back in October I re-ran tests with the netfilter bpf-jit patchset
in various different forwarding tests and config combinations.

Tests were done on a Intel(R) Xeon(R) CPU E5-2690 v4 @ 2.60GHZ machine, 14
(physical) cores, HT/SMT disabled.

Kernel config was based on that of Fedora 37; defaults are:
RETPOLINE=y, RETHUNK=y, Selinux enabled. I used nf-next tree, with HEAD
d2c806abcf0b582131e1f93589d628da ("netfilter: conntrack: use siphash_4u64").

Test uses pktgen in rx mode, exercising following path:
prerouting -> forward -> postrouting -> dummy0
Flows use 64byte udp packets that get forwarded to a dummy device.

I ran four test cases:

1. fwd: Plain forward: Base script, no special config except routing+forward
   enabled.
2. nf: same as 1), but there is a forward filter chain with one rule ('meta
   l4proto udp accept')
3. ct: same as 2), but there is a forward filter chain with a 'ct state new
   accept' rule, i.e. this config enables connection tracking.
   From conntrack point of view, this traffic is ideal: virtually all lookups
   will find an exisiting entry in the connection tracking table, i.e. this
   test does not exercise the new/delete conntrack path.
4. ft (flowtable): same as 3, but flows are added to the flowtable software bypass
   path.

Following table has results for the relevant Kconfig combinations:
CONFIG_RETPOLINE=y|n, SELinux (on/off), and BPF-JIT (on or off).

'SELinux off' means that I applied a small patch to remove the
nf_register_net_hooks() in security/selinux/hooks.c, this is NOT
a Kconfig change.
BPF-JIT off means I used undmodified nf-next, BPF-JIT on means
I used the latest version of the BPF-JIT patch set, avaialbe at:

https://git.breakpoint.cc/cgit/fw/nf-next.git/log/?h=nf_hook_jit_bpf_29

The third column shows percentage, with 'plain forward' treated as baseline.
The fourth column shows percentage with 'RETPOLINE=n SELinux off plain
forward' as the baseline.

Based on these results I will first work on removing the auto-registration
of the selinux hooks.  At least in the Fedora case, the default configuration
doesn't need them to be active as no secmarks or peer labels get added, so the
nf_register_net_hooks() calls should be delayed until the selinux policy
in a namespace sees a change that will require the hooks presence.

The BPF-JIT patchset doesn't help for RETPOLINE=n, so I will keep the
'depends on RETPOLINE' kconfig clause.
I plan to resubmit it for the *next* development cycle.

Meanhile I can also explore applying the same concept to other indirect calls
found in the network path, e.g. ndo_ops and see if anything is reusable.

------------------------------------------------------------------
RETPLINE=y, Selinux: On:
fwd: 682 Mb/s  1333582 pps    (100%)		( 77.7%)
nf:  635 Mb/s  1242167 pps    ( 93.1%)		( 72.4%)
ct:  486 Mb/s   951666 pps    ( 71.3%)		( 55.4%)
ft: 2952 Mb/s  5767297 pps    (432.8%)		(295.5%)

RETPLINE=y, Selinux: Off:
fwd: 776 Mb/s  1517938 pps   (100%)		( 88.4%)
nf:  710 Mb/s  1389293 pps   ( 91.5%)		( 80.9%)
ct:  520 Mb/s  1017144 pps   ( 67.0%)		( 59.2%)
ft: 2847 MB/s  5563505 pps   (366.9%)		(324.6%))

RETPLINE=y, Selinux: On, BPF-JIT:
fwd: 719 Mb/s  1406091 pps  (100%)		( 81.9%)
nf:  690 Mb/s  1349784 pps  ( 95.9%)		( 78.6%)
ct:  548 Mb/s  1072139 pps  ( 76.2%)		( 62.4%)
ft: 3227 Mb/s  6305546 pps  (448%)		(367.9%)

RETPLINE=y, Selinux: Off, BPF-JIT:
fwd: 777 Mb/s  1519260 pps   (100%)		( 88.5%)
nf:  727 Mb/s  1421397 pps   ( 93.6%)		( 82.8%)
ct:  564 Mb/s  1104244 pps   ( 72.5%)		( 64.3%)
ft: 3183 Mb/s  6218005 pps   (403.8%)		(357.8%)

RETPOLINE=n, Selinux: Off
fwd: 877 Mb/s  1713897 pps  (100%)		(100%)
nf:  812 Mb/s  1588642 pps  ( 92.6%)		( 92.5%))
ct:  629 Mb/s  1230907 pps  ( 71.72)		( 71.7%)
ft: 3127 Mb/s  6109677 pps			(356.5%)

RETPOLINE=n, Selinux: Off, BPF-JIT ON:
fwd: 875 Mb/s  1710246 pps  (100%)		( 99.7%)
nf:  811 Mb/s  1586071 pps  ( 92.6%)		( 92.4%)
ct:  617 Mb/s  1207447 pps  ( 70.5%)		( 70.3%)
ft: 3141 MB/s  6136657 pps  (358.9%)		(358.1%)

RETPOLINE=n, Selinux: On
fwd:  796 Mb/s  1556395 pps 			( 88.2%)
nf:   757 Mb/s  1479685 ppsi (95.1%)		( 86.3%)
ct:   603 Mb/s  1179356 pps  (75.7%)		( 68.7%)
ft:  3148 Mb/s  6150032 pps  (395.4%)		(358.9%)

RETPOLINE=n, Selinux: On, BPF-JIT ON:
fwd: 774 Mb/s  1514405 pps			( 88.2%)
nf:  737 Mb/s  1441554 pps  (95.2%)		( 84.0%)
ct:  600 Mb/s  1174251 pps  (77.5%)		( 68.4%)
ft: 3104 MB/s  6064567 pps  (401%)		(353.9%)
---------------------------------------------------------------

Let me know if you're interested in more details,
I can re-create this setup if needed.

