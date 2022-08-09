Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA6158DD22
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 19:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245041AbiHIRZX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 13:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245169AbiHIRZW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 13:25:22 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9D022A;
        Tue,  9 Aug 2022 10:25:18 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:53696)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oLSyj-00DfNP-Ed; Tue, 09 Aug 2022 11:25:17 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:33792 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oLSyh-002dz9-GI; Tue, 09 Aug 2022 11:25:17 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-usb@vger.kernel.org, bpf@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20220809094300.83116-1-hadess@hadess.net>
Date:   Tue, 09 Aug 2022 12:25:08 -0500
In-Reply-To: <20220809094300.83116-1-hadess@hadess.net> (Bastien Nocera's
        message of "Tue, 9 Aug 2022 11:42:58 +0200")
Message-ID: <87y1vx1g97.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oLSyh-002dz9-GI;;;mid=<87y1vx1g97.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX1+cCyXu6eLCt0w/0GFvnj61lRiEqcod9WI=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Bastien Nocera <hadess@hadess.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1416 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (0.8%), b_tie_ro: 9 (0.7%), parse: 0.77 (0.1%),
         extract_message_metadata: 9 (0.6%), get_uri_detail_list: 0.82 (0.1%),
        tests_pri_-1000: 10 (0.7%), tests_pri_-950: 0.99 (0.1%),
        tests_pri_-900: 0.78 (0.1%), tests_pri_-90: 50 (3.6%), check_bayes: 49
        (3.5%), b_tokenize: 4.7 (0.3%), b_tok_get_all: 6 (0.4%), b_comp_prob:
        1.74 (0.1%), b_tok_touch_all: 34 (2.4%), b_finish: 0.80 (0.1%),
        tests_pri_0: 1321 (93.3%), check_dkim_signature: 0.43 (0.0%),
        check_dkim_adsp: 2.8 (0.2%), poll_dns_idle: 1.18 (0.1%), tests_pri_10:
        2.2 (0.2%), tests_pri_500: 7 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/2] USB: core: add a way to revoke access to open USB
 devices
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bastien Nocera <hadess@hadess.net> writes:

> BPF list, first CC: here, I hope the commit messages are clear enough to
> understand the purpose of the patchset. If not, your comments would be
> greatly appreciated so I can make the commit messages self-explanatory.
>
> Eric, what would be the right identifier to use for a specific user
> namespace that userspace could find out? I know the PIDs of the
> bubblewrap processes that created those user namespaces, would those be
> good enough?

A namespace file descriptor would work. AKA The result of
opening /proc/<pid>/ns/user.

I assume you are asking so that you can filter the set of file
descriptors to revoked not by user but by user namespace.

Eric



> Changes since v2:
> - Changed the internal API to pass a struct usb_device
> - Fixed potential busy loop in user-space when revoking access to a
>   device
>
> Bastien Nocera (2):
>   USB: core: add a way to revoke access to open USB devices
>   usb: Implement usb_revoke() BPF function
>
>  drivers/usb/core/devio.c | 79 ++++++++++++++++++++++++++++++++++++++--
>  drivers/usb/core/usb.c   | 51 ++++++++++++++++++++++++++
>  drivers/usb/core/usb.h   |  2 +
>  3 files changed, 128 insertions(+), 4 deletions(-)
