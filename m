Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E7B6E9D51
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 22:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjDTUic (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 16:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjDTUib (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 16:38:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B9A55B8
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682023068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zbzvyPVA8WkCmb5k+MqK2idpL3zvt4GqaLfoewi5qpg=;
        b=LVrb1j5urjZW+5UogLTSjIVzqxA6gfd1ZnCSE9CPtGh+0IKUCxKLd0I7PghewCMG37OShV
        wPXRSzqlwbOwUFXwE3D3b5oTHTC1Q+RMDEBH7vCa0ffOY8bOgAFJ0TBxU9fYX0k8exoBa0
        LbIRw8+LgciwUisRnjWW6hbhy71ayeM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-8Vgnu6yoOpmN0FpiU9OvZw-1; Thu, 20 Apr 2023 16:37:45 -0400
X-MC-Unique: 8Vgnu6yoOpmN0FpiU9OvZw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33AF93C16E84;
        Thu, 20 Apr 2023 20:37:45 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.192.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A199D492C3E;
        Thu, 20 Apr 2023 20:37:43 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Artem Savkov <asavkov@redhat.com>,
        Viktor Malik <vmalik@redhat.com>, jmarchan@redhat.com
Subject: Re: sys_enter tracepoint ctx structure
References: <xunyjzy64q9b.fsf@redhat.com>
        <CAADnVQ+JdPGV95Y30PskgdOomU2K0UXsoCydgqaJfJ5j4S8BtQ@mail.gmail.com>
Date:   Thu, 20 Apr 2023 23:37:41 +0300
In-Reply-To: <CAADnVQ+JdPGV95Y30PskgdOomU2K0UXsoCydgqaJfJ5j4S8BtQ@mail.gmail.com>
        (Alexei Starovoitov's message of "Thu, 20 Apr 2023 08:59:09 -0700")
Message-ID: <xunyjzy6z3vu.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Alexei!

>>>>> On Thu, 20 Apr 2023 08:59:09 -0700, Alexei Starovoitov  wrote:

 > On Thu, Apr 20, 2023 at 6:57=E2=80=AFAM Yauheni Kaliuta <ykaliuta@redhat=
.com> wrote:
 >> Hi!
 >>=20
 >> Should perf_call_bpf_enter/exit (kernel/trace/trace_syscalls.c)
 >> use struct trace_event_raw_sys_enter/exit instead of locally
 >> crafted struct syscall_tp_t nowadays?


 > No. It needs syscall_tp_t.

 > test_progs's vmlinux test
 >> expects it as the context.
 >>=20

 > what do you mean? Pls share a code pointer?

https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/p=
rogs/test_vmlinux.c#L19

SEC("tp/syscalls/sys_enter_nanosleep")
int handle__tp(struct trace_event_raw_sys_enter *args)

So, should it use different structure then? syscall_tp_t to be
declared publicly?

 >>=20
 >> Or at least use struct trace_entry instead of struct pt_regs?
 >>=20

 > no. It needs a pointer to pt_regs.
 > See all of the pe_* flavor of helpers.


 >>=20
 >> I have a problem with one RT patch with extends trace_entry.
 >>=20

 > Just extend it. It shouldn't matter.
 > I'm likely missing something.

Or me. Let's figure out :)

--=20
WBR,
Yauheni Kaliuta

