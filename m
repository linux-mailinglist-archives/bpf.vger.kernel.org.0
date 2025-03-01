Return-Path: <bpf+bounces-52961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C98A4A8A0
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 05:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C4EB175BD9
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 04:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A2A1B85EE;
	Sat,  1 Mar 2025 04:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhIrrmLi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6848816BE3A
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 04:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740804052; cv=none; b=LAGTuPa/kJhXJYfNdwg9O+WO74X6itBoGw9mzCOSItn0RyTOmj15XxPjgKRl/EsehJPCKLLrLLVKY5XLZ+btCKnwibalPb1gG+LShDyyzA7MOV+HlZdbqmYYjDUBO+o4RyURv/bijWHQHrEa0Wa6lhsV1ww02jqpPynYR3OTWHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740804052; c=relaxed/simple;
	bh=GkVGHLkqZtW64pPXpsDc0FB0AWNGd3sUvbk5BUMClp4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ue7lo+YV0olGkqkmMafdBHK0CqiBv2NAA+rStQTpXUYE5D2+Z5D0Gfhuj9e0rABpX9SKr3JLgY+GIzs7ncpQZCIondujUEGGb0I3/vNDTVr109MZkctbd8tlOwTnH9eEcYDYRVc4FOrX9Hu5MVPeCz9Fbgjjok+cHX3Ft9SuRYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhIrrmLi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2234e4b079cso53831135ad.1
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 20:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740804049; x=1741408849; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hACQPWU9T2COJwAv7pMnglnRQEeNmdlT/XjU209cTzo=;
        b=dhIrrmLidbzWO6dlOwkm2kJma06Lw58HbYGlZ4qdnGZnPDHGTlIVvgtJvMDm29i5qk
         jy6dt8mw2KMjN5jyWows3JVf9VFIq6AY4aj/auII9bd9/j55qFpvetidanHRAq5/1Usz
         IDobb8akwMJYZ0RpjKd0eBXb47Kh2Kg5pVfU7CV9M8dN5YPqaygeJmKStmgTmBKceOfn
         44qsbY0c3sW96YlxWTlQ/HdFOt/I5O70P6zyOCYSBQ067t86RK2DASHrvWfiygHUaCFn
         rx8O1x7ONIXFJMZg+xci+o2dwNJJOZbSvmpHnUqPSOOCNry+ccQgJ91H3VgDACa5iMbf
         yLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740804049; x=1741408849;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hACQPWU9T2COJwAv7pMnglnRQEeNmdlT/XjU209cTzo=;
        b=iFlEKA823u4gcjFGAlQ+jDoannM40APxSr6fnMHiTGJkt09uwsHdYIsvB3ruNm6G3c
         gDuPhZ14FOlLNpzIOwTyLrORQEX7Zfiqn9UhjTOv2FYAAHBio+p2BBIR66fXPhFJHx98
         8H7W/KjL78x4c+kNJptQp/6c0TuzinYUAIs0h0jQoqw3H6+0HpGvNw6pH2et2MD1U5z2
         bdVX0PrGJD/i3/iJDH/krB7TatpBTH/1gcXi+Gsq0u4kQpHjTJl6JmbRujpyH5XzaHju
         zHysj8b4dGMIFWLDvY0CG61pRBbX4+wYdqsJeAb+DRwNvHPRUgvfNSB1kcBsEv59KLVy
         bLYQ==
X-Gm-Message-State: AOJu0Yy3KPMyRQlElT8n99xtgWJusFTA1xQ/CpX3QC++7KEX1N6uG5BI
	I54HWZnDoTHSTYW6PoKSh4vJprQZpon1i8t8OhtzyZDMOrov6WFlnj80bQ==
X-Gm-Gg: ASbGncvinJd3v2FdFJ7yqKZ720LNAnzRXY0uKUVyhs07YQe747SRkhQwrFL2QlpWDyP
	F+H8vXTci8gC5F12cSu/NyNDnVHWXWIK9Yaq39bdl2XqswkHj7PgoRsuhl5f1dS2XNaeDHfJgAD
	KpYFjziHRcxZfubD0irrzZaIwP2FaFOE8TJtm1cmEke7liVZSbVL2LLGDluwrDOeuSXjjC9rlif
	874g6Y9OpLxbUlKDP3wG7dimE4/yGHnCFRrYwymxKDZOC7iXchgY8DIltIH9LN45NEisu5Vxvs9
	FBz9tJrsEgTzOX5MI4TX8QijD+L/gWx4Qzb33Jud6Q==
X-Google-Smtp-Source: AGHT+IFd4k9njTPejWDwguzm2IOCWCspzmfHdhhj5xrcGChkk1VuuCiJWRd04azm2vNxd0fovmX9Aw==
X-Received: by 2002:a05:6a00:2d8e:b0:732:5276:4ac9 with SMTP id d2e1a72fcca58-734ac35cce9mr9627929b3a.9.1740804049464;
        Fri, 28 Feb 2025 20:40:49 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a0040100sm4773024b3a.137.2025.02.28.20.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 20:40:49 -0800 (PST)
Message-ID: <cc29975fbaf163d0c2ed904a9a4d6d9452177542.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] bpf: simple DFA-based live registers
 analysis
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>,
 Yonghong Song	 <yonghong.song@linux.dev>, Tejun Heo <tj@kernel.org>
Date: Fri, 28 Feb 2025 20:40:44 -0800
In-Reply-To: <CAADnVQ+BEW_yTsm-pMYcCsHhpZ4=FhAMmGvY7AhwyiUOZ+X1Gg@mail.gmail.com>
References: <20250228060032.1425870-1-eddyz87@gmail.com>
	 <CAADnVQ+BEW_yTsm-pMYcCsHhpZ4=FhAMmGvY7AhwyiUOZ+X1Gg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-28 at 18:10 -0800, Alexei Starovoitov wrote:

[...]

> I think the end goal is to get rid of mark_reg_read() and
> switch to proper live reg analysis.
> So please include the numbers to see how much work left.

Complete removal of mark_reg_read() means that analysis needs to be
done for stack slots as well. The algorithm to handle stack slots is
much more complicated:
- it needs to track register / stack slot type to handle cases like
  "r1 =3D r10" and spills of the stack pointer to stack;
- it needs to track register values, at-least crudely, to handle cases
  like "r1 =3D r10; r1 +=3D r2;" (array access).

The worst case scenario, as you suggested, is just to assume stack
slots live, but it is a big verification performance hit.
Exact numbers are at the end of the email.

> Also note that mark_reg_read() tracks 32 vs 64 reads separately.
> iirc we did it to support fine grain mark_insn_zext
> to help architectures where zext has to be inserted by JIT.
> I'm not sure whether new liveness has to do it as well.

As far as I understand, this is important for one check in
propagate_liveness(). And that check means something like:
"if this register was read as 64-bit value, remember that
 it needs zero extension on 32-bit load".

Meaning that either DFA would need to track this bit of information
(should be simple), or more zero extensions would be added.

---

Repository [1] shared in cover letter was used for benchmarks below.
Abbreviations are as follows:
- Name: dfa-opts
  Commit: b73005452a4a
  Meaning: DFA as shared in this patch-set + a set of small
           improvements which I decided to exclude from the
           patch-set as described in the cover letter.
- Name: dfa-opts-no-rm
  Commit: e486757fdada
  Meaning: dfa-opts + read marks are disabled for registers.
- Name: dfa-opts-no-rm-sl
  Commit: a9930e8127a9
  Meaning: dfa-opts + read marks are disabled for registers
           and stack.

[1] https://github.com/eddyz87/bpf/tree/liveregs-dfa-std-liveregs-off

Veristat output is filtered using -f "states_pct>5" -f "!insns<200".
Veristat results are followed by a histogram that accounts for all
tests.

Two comparisons are made:
- dfa-opts vs dfa-opts-no-rm (small negative impact, except two
  sched_ext programs that hit 1M instructions limit; positive impact
  would have indicated a bug);
- dfa-opts vs dfa-opts-no-rm-sl (big negative impact).

=3D=3D=3D=3D=3D=3D=3D=3D=3D selftests: dfa-opts vs dfa-opts-no-rm =3D=3D=3D=
=3D=3D=3D=3D=3D=3D

File                      Program           States (A)  States (B)  States =
(DIFF)
------------------------  ----------------  ----------  ----------  -------=
------
test_l4lb_noinline.bpf.o  balancer_ingress         219         231   +12 (+=
5.48%)

Total progs: 3565
Old success: 2054
New success: 2054
States diff min:    0.00%
States diff max:    5.48%
   0% ..    5%: 3564
   5% ..   10%: 1

=3D=3D=3D=3D=3D=3D=3D=3D=3D scx: dfa-opts vs dfa-opts-no-rm =3D=3D=3D=3D=3D=
=3D=3D=3D=3D

File       Program          States (A)  States (B)  States      (DIFF)
---------  ---------------  ----------  ----------  ------------------
bpf.bpf.o  rusty_init             1944       55004  +53060 (+2729.42%)
bpf.bpf.o  rusty_init_task        1732       55049  +53317 (+3078.35%)

Total progs: 216
Old success: 186
New success: 184
States diff min:    0.00%
States diff max: 3078.35%
   0% ..    5%: 214
2725% .. 3080%: 2



=3D=3D=3D=3D=3D=3D=3D=3D=3D selftests: dfa-opts vs dfa-opts-no-rm-sl =3D=3D=
=3D=3D=3D=3D=3D=3D=3D

File                              Program                               Sta=
tes (A)  States (B)  States     (DIFF)
--------------------------------  ------------------------------------  ---=
-------  ----------  -----------------
arena_htab_asm.bpf.o              arena_htab_asm                           =
     33          40       +7 (+21.21%)
bpf_cubic.bpf.o                   bpf_cubic_cong_avoid                     =
     92          98        +6 (+6.52%)
bpf_flow.bpf.o                    flow_dissector_0                         =
     66         125      +59 (+89.39%)
bpf_iter_ksym.bpf.o               dump_ksym                                =
     16          21       +5 (+31.25%)
profiler1.bpf.o                   kprobe__proc_sys_write                   =
     84         140      +56 (+66.67%)
profiler1.bpf.o                   kprobe__vfs_link                         =
    504         543       +39 (+7.74%)
profiler1.bpf.o                   kprobe__vfs_symlink                      =
    238         466     +228 (+95.80%)
profiler1.bpf.o                   kprobe_ret__do_filp_open                 =
    247         274      +27 (+10.93%)
profiler1.bpf.o                   raw_tracepoint__sched_process_exec       =
    139         350    +211 (+151.80%)
profiler1.bpf.o                   raw_tracepoint__sched_process_exit       =
     67          86      +19 (+28.36%)
profiler1.bpf.o                   tracepoint__syscalls__sys_enter_kill     =
    649         758     +109 (+16.80%)
profiler2.bpf.o                   kprobe__vfs_link                         =
    149         257     +108 (+72.48%)
profiler2.bpf.o                   kprobe_ret__do_filp_open                 =
    106         120      +14 (+13.21%)
profiler2.bpf.o                   raw_tracepoint__sched_process_exec       =
    126         140      +14 (+11.11%)
profiler3.bpf.o                   kprobe__vfs_link                         =
    805        1182     +377 (+46.83%)
pyperf180.bpf.o                   on_event                                 =
  10564       17659    +7095 (+67.16%)
pyperf50.bpf.o                    on_event                                 =
   2489        3375     +886 (+35.60%)
pyperf600_iter.bpf.o              on_event                                 =
    192         214      +22 (+11.46%)
pyperf_subprogs.bpf.o             on_event                                 =
   2331        2514      +183 (+7.85%)
setget_sockopt.bpf.o              skops_sockopt                            =
    429         458       +29 (+6.76%)
setget_sockopt.bpf.o              socket_post_create                       =
     90          95        +5 (+5.56%)
sock_iter_batch.bpf.o             iter_tcp_soreuse                         =
      3           5       +2 (+66.67%)
strobemeta_bpf_loop.bpf.o         on_event                                 =
    209         331     +122 (+58.37%)
test_bpf_nf.bpf.o                 nf_skb_ct_test                           =
     41          56      +15 (+36.59%)
test_bpf_nf.bpf.o                 nf_xdp_ct_test                           =
     41          56      +15 (+36.59%)
test_cls_redirect.bpf.o           cls_redirect                             =
   2175       14083  +11908 (+547.49%)
test_cls_redirect_dynptr.bpf.o    cls_redirect                             =
    220         327     +107 (+48.64%)
test_cls_redirect_subprogs.bpf.o  cls_redirect                             =
   4390       17001  +12611 (+287.27%)
test_l4lb.bpf.o                   balancer_ingress                         =
    137         256     +119 (+86.86%)
test_l4lb_noinline.bpf.o          balancer_ingress                         =
    219         643    +424 (+193.61%)
test_l4lb_noinline_dynptr.bpf.o   balancer_ingress                         =
     73         182    +109 (+149.32%)
test_misc_tcp_hdr_options.bpf.o   misc_estab                               =
     88          98      +10 (+11.36%)
test_pkt_access.bpf.o             test_pkt_access                          =
     21          25       +4 (+19.05%)
test_sock_fields.bpf.o            egress_read_sock_fields                  =
     20          29       +9 (+45.00%)
test_tc_neigh_fib.bpf.o           tc_dst                                   =
     12          14       +2 (+16.67%)
test_tc_neigh_fib.bpf.o           tc_src                                   =
     12          14       +2 (+16.67%)
test_tcp_custom_syncookie.bpf.o   tcp_custom_syncookie                     =
    420         560     +140 (+33.33%)
test_tcp_hdr_options.bpf.o        estab                                    =
    189         225      +36 (+19.05%)
test_xdp.bpf.o                    _xdp_tx_iptunnel                         =
     17          18        +1 (+5.88%)
test_xdp_dynptr.bpf.o             _xdp_tx_iptunnel                         =
     26          36      +10 (+38.46%)
test_xdp_loop.bpf.o               _xdp_tx_iptunnel                         =
     19          20        +1 (+5.26%)
test_xdp_noinline.bpf.o           balancer_ingress_v4                      =
    271        1080    +809 (+298.52%)
test_xdp_noinline.bpf.o           balancer_ingress_v6                      =
    268        1030    +762 (+284.33%)
xdp_features.bpf.o                xdp_do_tx                                =
     10          13       +3 (+30.00%)
xdp_synproxy_kern.bpf.o           syncookie_tc                             =
    390         467      +77 (+19.74%)
xdp_synproxy_kern.bpf.o           syncookie_xdp                            =
    384         450      +66 (+17.19%)

Total progs: 3565
Old success: 2054
New success: 2054
States diff min:   -9.09%
States diff max:  547.49%
 -10% ..    0%: 3
   0% ..    5%: 3492
   5% ..   10%: 10
  10% ..   15%: 8
  15% ..   20%: 10
  20% ..   25%: 6
  25% ..   35%: 8
  35% ..   40%: 4
  45% ..   50%: 3
  50% ..   55%: 4
  55% ..   70%: 4
  70% ..   90%: 3
  95% ..  105%: 3
 145% ..  195%: 3
 280% ..  300%: 3
 545% ..  550%: 1

=3D=3D=3D=3D=3D=3D=3D=3D=3D scx: dfa-opts vs dfa-opts-no-rm-sl =3D=3D=3D=3D=
=3D=3D=3D=3D=3D

File            Program             States (A)  States (B)  States      (DI=
FF)
--------------  ------------------  ----------  ----------  ---------------=
---
bpf.bpf.o       bpfland_enqueue             18          20        +2 (+11.1=
1%)
bpf.bpf.o       bpfland_select_cpu          83         103       +20 (+24.1=
0%)
bpf.bpf.o       flash_select_cpu            30          49       +19 (+63.3=
3%)
bpf.bpf.o       lavd_cpu_offline           303         360       +57 (+18.8=
1%)
bpf.bpf.o       lavd_cpu_online            303         360       +57 (+18.8=
1%)
bpf.bpf.o       lavd_dispatch             7065       10652     +3587 (+50.7=
7%)
bpf.bpf.o       lavd_init                  480         554       +74 (+15.4=
2%)
bpf.bpf.o       lavd_running                89          94         +5 (+5.6=
2%)
bpf.bpf.o       lavd_select_cpu            451         483        +32 (+7.1=
0%)
bpf.bpf.o       layered_dispatch           501         950      +449 (+89.6=
2%)
bpf.bpf.o       layered_dump               237         258        +21 (+8.8=
6%)
bpf.bpf.o       layered_enqueue           1290        1655      +365 (+28.2=
9%)
bpf.bpf.o       layered_init               423         552      +129 (+30.5=
0%)
bpf.bpf.o       layered_select_cpu         201         311      +110 (+54.7=
3%)
bpf.bpf.o       p2dq_dispatch               53         116      +63 (+118.8=
7%)
bpf.bpf.o       rusty_init                1944       55006  +53062 (+2729.5=
3%)
bpf.bpf.o       rusty_init_task           1732       55052  +53320 (+3078.5=
2%)
bpf.bpf.o       rusty_running               19          23        +4 (+21.0=
5%)
bpf.bpf.o       rusty_select_cpu           108         227     +119 (+110.1=
9%)
bpf.bpf.o       rusty_set_cpumask          313         479      +166 (+53.0=
4%)
scx_nest.bpf.o  nest_select_cpu             49          53         +4 (+8.1=
6%)

Total progs: 216
Old success: 186
New success: 184
States diff min:    0.00%
States diff max: 3078.52%
   0% ..    5%: 186
   5% ..   10%: 4
  10% ..   15%: 5
  15% ..   20%: 6
  20% ..   25%: 3
  25% ..   55%: 6
  60% ..  115%: 3
 115% .. 3080%: 3


