Return-Path: <bpf+bounces-15081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC49B7EBAAC
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 01:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C5611C20AC6
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 00:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4042739E;
	Wed, 15 Nov 2023 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E621839F
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 00:45:56 +0000 (UTC)
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FE4DC
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 16:45:52 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id B245A240027
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 01:45:50 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4SVPbd5kJpz9rxF
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 01:45:49 +0100 (CET)
Date: Wed, 15 Nov 2023 00:45:46 +0000
From: Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To: bpf@vger.kernel.org
Subject: BPF CI email notifications
Message-ID: <eirb3ygold3flp7p6gtj76pii2q43mli6ocoe5btqwwwz36vsw@tnvv4w2ekgz3>
Reply-To: kernel-ci@meta.com
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

As I am sure most of you are aware, BPF has a CI system that runs on all patch
submissions. Details have been presented at various conferences, with several
recordings and slide decks detailing workings available (e.g., [0]). In the past
this system has, in large parts, been a tool for maintainers to quickly spot
problems, as results get bubbled up to Patchwork [1].

We believe that it is equally important for patch submitters to be made aware of
CI results. To that end, we added support for email notifications to the CI
system a while back. For some time now, these notifications had been enabled for
chosen Meta BPF developers as well as BPF maintainers to gather and address
feedback.

At this point, we would like to take the next step and have notification emails
go out to *all* patch submitters.

# What to expect

Everybody submitting a patch will be informed about success or failure of said
submission once CI concluded or a failure has been detected via email. A link to
the GitHub Actions run will be included (e.g., [2]), which allows for quick
navigation to the individual failed test runs in case of failure.

All emails originate from bot+bpf-ci@kernel.org, allowing for easy filtering.

Note that as per our current CI design, patches are effectively tested
continuously. That is, if an update is pushed to the upstream branch (bpf or
bpf-next), the patch will be rebased and retested. An email notification will
only be sent if the current result is different from what it was before (i.e.,
success -> failure or failure -> success). New patch versions (e.g., update from
v1 -> v2) will always trigger a new email initially.

Please also note that while the Kernel CI team at Meta tries to address
infrastructure issues affecting the CI system in a timely manner, we do not have
the resources to fix all sources of selftest flakiness. We encourage everyone to
send out fixes addressing problems, including when not directly caused by their
submission. It is in this context that submissions such as Tao's recent
test_maps fix [3] are very valuable and will only become more so as test
flakiness has the potential to affect more people (thanks!).

# Moving forward

If you have any concerns or want to be excluded from CI emails for your
submissions, please reach out to kernel-ci@meta.com. If not, expect to receive
email notifications for your own patch submissions starting some time next week.
Once enabled, please feel free to share any feedback you have with
kernel-ci@meta.com. Eventually, our intent is to CC the bpf mailing list on
all such CI emails.

Regards,
Daniel (on behalf of the Kernel CI team at Meta)

[0] http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-bpf-ci.pdf
[1] https://patchwork.kernel.org/project/netdevbpf/list/
[2] https://github.com/kernel-patches/bpf/actions/runs/6867078893
[3] https://lore.kernel.org/bpf/20231101032455.3808547-1-houtao@huaweicloud.com/

