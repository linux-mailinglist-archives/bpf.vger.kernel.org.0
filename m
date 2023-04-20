Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61C26E9E02
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 23:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjDTVlW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 17:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjDTVlW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 17:41:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC82130F1
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 14:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682026839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+oo1u1B0iY29kZwhp1M2+TzCszYug36kVhxQNzOopN8=;
        b=QBzIbIyIE0hN/WgKTK5TtiZzK0RxRX+O42XcjPDkjGgjF+s8E5fcn98vKOqHaSP/TGREPa
        eAhr8l0pAgq1BdKxFKioUL6nw4AMAJc2ki78YDGgFecyxZgkpHQCEPrq5aIlePBPHNXlJM
        yk18z+R8fPRyqs1DuuG3qXbSneyuVD0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-3Q5dA8I4NfCN88EhSpFEEQ-1; Thu, 20 Apr 2023 17:40:38 -0400
X-MC-Unique: 3Q5dA8I4NfCN88EhSpFEEQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 21BBD1C07561;
        Thu, 20 Apr 2023 21:40:38 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.192.158])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D32D492C3E;
        Thu, 20 Apr 2023 21:40:36 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Artem Savkov <asavkov@redhat.com>,
        Viktor Malik <vmalik@redhat.com>,
        Jerome Marchand <jmarchan@redhat.com>
Subject: Re: sys_enter tracepoint ctx structure
References: <xunyjzy64q9b.fsf@redhat.com>
        <CAADnVQ+JdPGV95Y30PskgdOomU2K0UXsoCydgqaJfJ5j4S8BtQ@mail.gmail.com>
        <xunyjzy6z3vu.fsf@redhat.com>
        <CAADnVQK-Dig-5DB6tM_sgggyvqHUXSbBud0R=rAPWT2VRtQ-ZQ@mail.gmail.com>
Date:   Fri, 21 Apr 2023 00:40:34 +0300
In-Reply-To: <CAADnVQK-Dig-5DB6tM_sgggyvqHUXSbBud0R=rAPWT2VRtQ-ZQ@mail.gmail.com>
        (Alexei Starovoitov's message of "Thu, 20 Apr 2023 13:54:26 -0700")
Message-ID: <xunyfs8uz0z1.fsf@redhat.com>
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

>>>>> On Thu, 20 Apr 2023 13:54:26 -0700, Alexei Starovoitov  wrote:
 > On Thu, Apr 20, 2023 at 1:37=E2=80=AFPM Yauheni Kaliuta <ykaliuta@redhat=
.com> wrote:
 >> >>>>> On Thu, 20 Apr 2023 08:59:09 -0700, Alexei Starovoitov  wrote:
 >> >>
 >> >> Should perf_call_bpf_enter/exit (kernel/trace/trace_syscalls.c)
 >> >> use struct trace_event_raw_sys_enter/exit instead of locally
 >> >> crafted struct syscall_tp_t nowadays?
 >>=20
 >>=20
 >> > No. It needs syscall_tp_t.
 >>=20
 >> > test_progs's vmlinux test
 >> >> expects it as the context.
 >> >>
 >>=20
 >> > what do you mean? Pls share a code pointer?
 >>=20
 >> https://github.com/torvalds/linux/blob/master/tools/testing/selftests/b=
pf/progs/test_vmlinux.c#L19
 >>=20
 >> SEC("tp/syscalls/sys_enter_nanosleep")
 >> int handle__tp(struct trace_event_raw_sys_enter *args)

 > I see. That bit is correct and that's what bpftrace is doing
 > when attaching to syscalls.
 > What do you see in your patched RT kernel when you do:
 > cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/format
 > ?
 > Depending on the answer we might need to fix
 > the kernel side that has to use struct trace_entry
 > in syscall_tp_t instead of plain long long.

 # cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_nanosleep/format
name: sys_enter_nanosleep
ID: 374
format:
        field:unsigned short common_type;       offset:0;       size:2; sig=
ned:0;
        field:unsigned char common_flags;       offset:2;       size:1; sig=
ned:0;
        field:unsigned char common_preempt_count;       offset:3;       siz=
e:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;
        field:unsigned char common_preempt_lazy_count;  offset:8;       siz=
e:1; signed:0;

        field:int __syscall_nr; offset:12;      size:4; signed:1;
        field:struct __kernel_timespec * rqtp;  offset:16;      size:8; sig=
ned:0;
        field:struct __kernel_timespec * rmtp;  offset:24;      size:8; sig=
ned:0;

print fmt: "rqtp: 0x%08lx, rmtp: 0x%08lx", ((unsigned long)(REC->rqtp)), ((=
unsigned long)(REC->rmtp))



--=20
WBR,
Yauheni Kaliuta

