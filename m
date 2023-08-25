Return-Path: <bpf+bounces-8617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5EC788B8A
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF53C281A14
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C891078E;
	Fri, 25 Aug 2023 14:21:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F28210784
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 14:21:18 +0000 (UTC)
X-Greylist: delayed 2650 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Aug 2023 07:21:02 PDT
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F122137;
	Fri, 25 Aug 2023 07:21:02 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:50416)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qZWz8-00GBtW-AP; Fri, 25 Aug 2023 07:36:22 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:38324 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qZWz6-00E4Wv-P3; Fri, 25 Aug 2023 07:36:21 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Yonghong Song <yhs@fb.com>,  Kui-Feng Lee <kuifeng@fb.com>,  Andrii
 Nakryiko <andrii@kernel.org>,  Martin KaFai Lau <martin.lau@kernel.org>,
  bpf@vger.kernel.org,  linux-kernel@vger.kernel.org
References: <20230821150909.GA2431@redhat.com>
	<20230825124115.GA13849@redhat.com>
Date: Fri, 25 Aug 2023 08:36:13 -0500
In-Reply-To: <20230825124115.GA13849@redhat.com> (Oleg Nesterov's message of
	"Fri, 25 Aug 2023 14:41:15 +0200")
Message-ID: <87fs47qm5u.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qZWz6-00E4Wv-P3;;;mid=<87fs47qm5u.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1/v0CeTMpQDzRSGn8J9slRx4Jf3faq+kl8=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Virus: No
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 962 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 4.3 (0.4%), b_tie_ro: 3.0 (0.3%), parse: 1.05
	(0.1%), extract_message_metadata: 11 (1.2%), get_uri_detail_list: 1.75
	(0.2%), tests_pri_-2000: 10 (1.0%), tests_pri_-1000: 1.88 (0.2%),
	tests_pri_-950: 1.02 (0.1%), tests_pri_-900: 0.79 (0.1%),
	tests_pri_-200: 0.66 (0.1%), tests_pri_-100: 3.4 (0.4%),
	tests_pri_-90: 206 (21.4%), check_bayes: 201 (20.9%), b_tokenize: 4.3
	(0.5%), b_tok_get_all: 147 (15.3%), b_comp_prob: 2.2 (0.2%),
	b_tok_touch_all: 45 (4.7%), b_finish: 0.72 (0.1%), tests_pri_0: 182
	(18.9%), check_dkim_signature: 0.37 (0.0%), check_dkim_adsp: 2.4
	(0.2%), poll_dns_idle: 526 (54.7%), tests_pri_10: 2.6 (0.3%),
	tests_pri_500: 534 (55.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] bpf: task_group_seq_get_next: cleanup the usage of
 next_thread()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Oleg Nesterov <oleg@redhat.com> writes:

> OK, it seems that you are not going to take these preparatory
> cleanups ;)
>
> I'll resend along with the s/next_thread/__next_thread/ change.
> I was going to do the last change later, but this recent discussion
> https://lore.kernel.org/all/20230824143112.GA31208@redhat.com/
> makes me think we should do this right now.

For the record I find this code confusing, and wrong.

It looks like it wants to keep the task_struct pointer or possibly the
struct pid pointer like proc does, but then it winds up keeping a
userspace pid value and regenerating both the struct pid pointer and
the struct task_struct pointer.

Which means that task_group_seq_get_next is unnecessarily slow and has
a built in race condition which means it could wind up iterating through
a different process.

This whole thing looks to be a bad (aka racy) reimplementation of
first_tid and next_tid from proc.  I thought the changes were to
adapt to the needs of bpf, but on closer examination the code is
just racy.

For this code to be correct bpf_iter_seq_task_common needs to store
at a minimum a struct pid pointer.


Oleg your patch makes it easier to see what the how
far this is from first_tid/next_tid in proc.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Eric

