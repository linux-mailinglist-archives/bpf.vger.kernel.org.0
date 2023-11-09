Return-Path: <bpf+bounces-14629-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AEB7E7272
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 20:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E85F281270
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 19:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADFD36B19;
	Thu,  9 Nov 2023 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFX6px0Y"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1873B36AFE
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 19:49:24 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F653C14
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 11:49:23 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9c2a0725825so220261166b.2
        for <bpf@vger.kernel.org>; Thu, 09 Nov 2023 11:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699559361; x=1700164161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWl+K/xyDf3o3yQDBH94OJHi6JLS+145RUMUM/+pf+4=;
        b=gFX6px0YKZCawZiIZT54RnRY2skPtiEHb7+xo5TKerJsFAuznKbqlOlPkrAmXbwXB1
         euY3Ik+p7WhE2j7tot1uM/dNRTiu++uLqJJHmhj74TpQ20ICzjXXE5/Y1V4PWJY27HTy
         ChGYSymXv44/Q7wVvKsqlUEzk2wJ6GpX6EbUV9KFZsfKpxonvTTi+pTE2Ru/N5SHBbTo
         ccaCaIlp/J8cUQ3PnFw0h7XdP8kc4pw6cKKSJhYCmq2380oUiyhVqOwRW5RR+otWZAeT
         Lu5rY5vT8ZeYAorGPwihpP4Hbc4hcm4mP6deYfRghXG5qv1zGFOHuAfh2HY95WZBohTi
         iEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699559361; x=1700164161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWl+K/xyDf3o3yQDBH94OJHi6JLS+145RUMUM/+pf+4=;
        b=ez/iNdaAvgZ+MENb2tXa4q4OG2DPzdJZDdTx6D38fvqCZYUK+v64WVZGsHtZdd+/s+
         KoRiGIdY5exPZvZ74b80FGMTREkPPYo5lcIkuQLUs0kcYQVIdGg0S+xDeQ6TI5OoBSDW
         +Z5lEVyE694D9Bva2dKw4IZ1lQZax42uRYKrTqsjAlKqrLl/EJCjFThJR1EUwcgVXvHS
         PU8qKZd2PhIOsAPmgljSP5n+P6yhDakstC9KSwIzCNMKvXsv6KNyDrhGlwhuTlubmVy4
         GkDB9ZHjnaeQvEm+lk1XRflcbDnJ3jAgYWtrhWBzzIb6YH/7s75I22IZbesm5fGYNigx
         f1pQ==
X-Gm-Message-State: AOJu0Yw2bOt5hQtwexZ/YeQMNp6pi4pjeiEfNo/iuWKFGntibulHxpc2
	ax2/9bW2fVgKX74wt7fVOmUQNX1nTANq1NFGG4xnD+iHxr8=
X-Google-Smtp-Source: AGHT+IFdiFEP4ON5UQi8MnVwmV3GwplbLNisvI3rmw69Gf2zaZ+T+N+3RllF3uOznVoJSqqIMSsu+3W+eBI998V8pWw=
X-Received: by 2002:a17:907:6e94:b0:9d1:73da:e4fc with SMTP id
 sh20-20020a1709076e9400b009d173dae4fcmr5278475ejc.73.1699559361296; Thu, 09
 Nov 2023 11:49:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231031050324.1107444-1-andrii@kernel.org> <20231031050324.1107444-2-andrii@kernel.org>
 <43f0d9f7219b74bfaff14b6496902f1056847de7.camel@gmail.com>
 <CAADnVQL6_o9z3z1=8o7qGNzAD8vKMZ+OetcYYy-1huxGfCJToA@mail.gmail.com>
 <CAEf4BzaA12xjXm8KZNB1mkVDOTtVDQDDWF4nYQtQ2qRYoTip3A@mail.gmail.com> <CAADnVQLGn4vRuZLqTm_t_9ff3t=Hsugr0j47YLThhPsnpNrs_Q@mail.gmail.com>
In-Reply-To: <CAADnVQLGn4vRuZLqTm_t_9ff3t=Hsugr0j47YLThhPsnpNrs_Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 11:49:09 -0800
Message-ID: <CAEf4BzY72H_0fF4C1kGbX5_ymNu6NHYf55HAnU8i5dnaQ+f_vA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: use common jump (instruction) history
 across all states
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 11:29=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 9, 2023 at 9:28=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> >
> > If we ever break DFS property, we can easily change this. Or we can
> > even have a hybrid: as long as traversal preserves DFS property, we
> > use global shared history, but we can also optionally clone and have
> > our own history if necessary. It's a matter of adding optional
> > potentially NULL pointer to "local history". All this is very nicely
> > hidden away from "normal" code.
>
> If we can "easily change this" then let's make it last and optional patch=
.
> So we can revert in the future when we need to take non-DFS path.

Ok, sounds good. I'll reorder and put it last, you can decide whether
to apply it or not that way.

>
> > But again, let's look at data first. I'll get back with numbers soon.
>
> Sure. I think memory increase due to more tracking is ok.
> I suspect it won't cause 2x increase. Likely few %.
> The last time I checked the main memory hog is states stashed for pruning=
.

So I'm back with data. See verifier.c changes I did at the bottom,
just to double check I'm not missing something major. I count the
number of allocations (but that's an underestimate that doesn't take
into account realloc), total number of instruction history entries for
entire program verification, and then also peak "depth" of instruction
history. Note that entries should be multiplied by 8 to get the amount
of bytes (and that's not counting per-allocation overhead).

Here are top 20 results, sorted by number of allocs for Meta-internal,
Cilium, and selftests. BEFORE is without added STACK_ACCESS tracking
and STACK_ZERO optimization. AFTER is with all the patches of this
patch set applied.

It's a few megabytes of memory allocation, which in itself is probably
not a big deal. But it's just an amount of unnecessary memory
allocations which is basically at least 2x of the total number of
states that we can save. And instead have just a few reallocs to size
global jump history to an order of magnitudes smaller peak entries.

And if we ever decide to track more stuff similar to
INSNS_F_STACK_ACCESS, we won't have to worry about more allocations or
more memory usage, because the absolute worst case is our global
history will be up to 1 million entries tops. We can track some *code
path dependent* per-instruction information for *each simulated
instruction* easily without having to think twice about this. Which I
think is a nice liberating thought in itself justifying this change.


META BEFORE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[vmuser@archvm bpf]$ sudo veristat -e
prog,insns,states,jmp_allocs,jmp_total,jmp_peak -R
~/insn-hist-before-results-fbcode.csv -s jmp_allocs -n 20
Program                                    Insns  States  Jumphist
allocs  Jumphist total entries  Jumphist peak entries
----------------------------------------  ------  ------
---------------  ----------------------  ---------------------
syar_file_open                            712974   51407
154982                  546559                    742
balancer_ingress                          339626   26535
92061                  106593                     61
vip_filter                                457002   33010
83432                  201396                    276
tw_twfw_egress                            511127   16733
81485                  382989                   4379
tw_twfw_tc_eg                             511113   16732
81484                  382987                   4379
tw_twfw_ingress                           500095   16223
80974                  381708                   4379
tw_twfw_tc_in                             500095   16223
80974                  381708                   4379
adns                                      384816   11145
41882                  128399                     52
cls_fg_dscp                               217709   13908
28163                   59291                    117
edgewall                                  179715   12607
26886                   51134                     74
mount_audit                                87915    1938
19198                  104412                    315
xdpdecap                                   62648    5577
17530                   18315                     38
xdpdecap                                   62648    5577
17530                   18315                     38
xdpdecap                                   62648    5577
17530                   18315                     38
xdpdecap                                   58507    4687
16527                   18613                     40
syar_lsm_file_open                        167772    1836
12720                   90107                   2107
tcdecapstats                               38691    3112
10991                   12371                     34
twfw_connect6                              44399    1974
9864                   36320                   1797
twfw_sendmsg6                              44399    1974
9864                   36320                   1797
on_pytorch_event                          100370    2153
7102                   25661                    199

META AFTER
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[vmuser@archvm bpf]$ sudo veristat -e
prog,insns,states,jmp_allocs,jmp_total,jmp_peak -R
~/insn-hist-after-results-fbcode.csv -s jmp_allocs -n 20
Program                                    Insns  States  Jumphist
allocs  Jumphist total entries  Jumphist peak entries
----------------------------------------  ------  ------
---------------  ----------------------  ---------------------
syar_file_open                            707473   51263
154488                  431397                    464
balancer_ingress                          334452   26438
91881                  107822                    114
vip_filter                                457002   33010
83432                  287548                    374
adns                                      384816   11145
41882                   86357                    274
tw_twfw_egress                            212071    8504
33886                  161518                   5184
tw_twfw_ingress                           212069    8504
33886                  161515                   5184
tw_twfw_tc_eg                             212064    8504
33886                  161515                   5184
tw_twfw_tc_in                             212069    8504
33886                  161515                   5184
cls_fg_dscp                               213184   13702
27722                  118594                    281
mount_audit                                87915    1938
19198                  103835                    202
xdpdecap                                   62648    5577
17530                   25723                     96
xdpdecap                                   62648    5577
17530                   25723                     96
xdpdecap                                   62648    5577
17530                   25723                     96
xdpdecap                                   58507    4687
16527                   18674                     54
syar_lsm_file_open                        151813    1667
11530                   21841                    215
tcdecapstats                               38691    3112
10991                   12373                     35
twfw_connect6                              44399    1974
9864                   63516                   4378
twfw_sendmsg6                              44399    1974
9864                   63516                   4378
edgewall                                   55783    3999
8467                   31874                    187
on_pytorch_event                          102649    2152
7140                   33563                    250

CILIUM BEFORE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[vmuser@archvm bpf]$ sudo veristat -e
file,prog,insns,states,jmp_allocs,jmp_total,jmp_peak -R
~/insn-hist-before-results-cilium.csv -s jmp_allocs -n 20
File                Program                           Insns  States
Jumphist allocs  Jumphist total entries  Jumphist peak entries
------------------  --------------------------------  -----  ------
---------------  ----------------------  ---------------------
bpf_xdp.o           tail_lb_ipv6                      80441    3647
         6976                   12471                    105
bpf_xdp.o           tail_lb_ipv4                      39492    2430
         4581                    8117                    105
bpf_host.o          tail_nodeport_nat_egress_ipv4     22460    1469
         2926                    5302                    226
bpf_overlay.o       tail_nodeport_nat_egress_ipv4     22718    1475
         2926                    5285                    227
bpf_host.o          tail_handle_nat_fwd_ipv4          21022    1289
         2498                    4924                    236
bpf_lxc.o           tail_handle_nat_fwd_ipv4          21022    1289
         2498                    4924                    236
bpf_overlay.o       tail_handle_nat_fwd_ipv4          20524    1271
         2465                    4844                    221
bpf_xdp.o           tail_rev_nodeport_lb6             16173    1010
         1934                    3137                     65
bpf_host.o          tail_handle_nat_fwd_ipv6          15433     905
         1802                    3662                    224
bpf_lxc.o           tail_handle_nat_fwd_ipv6          15433     905
         1802                    3662                    224
bpf_xdp.o           tail_handle_nat_fwd_ipv4          12917     875
         1638                    2986                    245
bpf_xdp.o           tail_nodeport_nat_egress_ipv4     13027     868
         1628                    2957                    227
bpf_xdp.o           tail_handle_nat_fwd_ipv6          13515     715
         1391                    2492                    215
bpf_xdp.o           tail_nodeport_nat_ingress_ipv4     7617     522
          985                    1736                     63
bpf_host.o          cil_to_netdev                      6047     362
          783                    1334                     48
bpf_xdp.o           tail_rev_nodeport_lb4              6808     403
          761                    1319                     77
bpf_xdp.o           tail_nodeport_nat_ingress_ipv6     7575     383
          722                    1261                     63
bpf_host.o          tail_nodeport_nat_ingress_ipv4     5526     366
          693                    1196                     40
bpf_lxc.o           tail_nodeport_nat_ingress_ipv4     5526     366
          693                    1196                     40
bpf_overlay.o       tail_nodeport_nat_ingress_ipv4     5526     366
          693                    1196                     40

CILIUM AFTER
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[vmuser@archvm bpf]$ sudo veristat -e
file,prog,insns,states,jmp_allocs,jmp_total,jmp_peak -R
~/insn-hist-after-results-cilium.csv -s jmp_allocs -n 20
File                Program                           Insns  States
Jumphist allocs  Jumphist total entries  Jumphist peak entries
------------------  --------------------------------  -----  ------
---------------  ----------------------  ---------------------
bpf_xdp.o           tail_lb_ipv6                      78058    3523
         6810                   19903                    192
bpf_xdp.o           tail_lb_ipv4                      36367    2251
         4293                   11975                    205
bpf_host.o          tail_nodeport_nat_egress_ipv4     19862    1293
         2568                    7021                    305
bpf_overlay.o       tail_nodeport_nat_egress_ipv4     19490    1275
         2552                    6990                    303
bpf_xdp.o           tail_rev_nodeport_lb6             15847     990
         1909                    4533                     96
bpf_xdp.o           tail_handle_nat_fwd_ipv4          12443     849
         1608                    4177                    315
bpf_xdp.o           tail_nodeport_nat_egress_ipv4     12096     809
         1523                    4140                    290
bpf_xdp.o           tail_handle_nat_fwd_ipv6          13264     702
         1378                    3535                    271
bpf_host.o          tail_handle_nat_fwd_ipv4          10479     670
         1325                    3891                    315
bpf_lxc.o           tail_handle_nat_fwd_ipv4          10479     670
         1325                    3891                    315
bpf_host.o          tail_handle_nat_fwd_ipv6          11375     643
         1292                    3523                    288
bpf_lxc.o           tail_handle_nat_fwd_ipv6          11375     643
         1292                    3523                    288
bpf_overlay.o       tail_handle_nat_fwd_ipv4          10114     638
         1266                    3738                    274
bpf_xdp.o           tail_nodeport_nat_ingress_ipv4     5900     413
          773                    1891                     92
bpf_xdp.o           tail_rev_nodeport_lb4              6739     396
          750                    1899                    136
bpf_xdp.o           tail_nodeport_nat_ingress_ipv6     7395     374
          711                    1732                     97
bpf_host.o          cil_to_netdev                      4578     249
          512                    1223                     97
bpf_host.o          tail_handle_ipv6_from_host         4168     244
          499                    1338                     91
bpf_host.o          tail_handle_ipv4_from_host         3434     231
          477                    1170                     97
bpf_host.o          tail_nodeport_nat_ingress_ipv4     3534     243
          474                    1344                     77

SELFTESTS BEFORE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[vmuser@archvm bpf]$ sudo veristat -e
file,prog,insns,states,jmp_allocs,jmp_total,jmp_peak -R
~/insn-hist-before-results-selftests.csv -s jmp_allocs -n 20
File                                       Program
     Insns  States  Jumphist allocs  Jumphist total entries  Jumphist
peak entries
-----------------------------------------
-----------------------------  -------  ------  ---------------
----------------------  ---------------------
pyperf600_nounroll.bpf.linked3.o           on_event
    533132   34227            67332                  201368
      15100
pyperf600.bpf.linked3.o                    on_event
    475837   22259            48488                  125533
       9675
verifier_loops1.bpf.linked3.o
loop_after_a_conditional_jump  1000001   25000            25000
          499983                 499999
strobemeta.bpf.linked3.o                   on_event
    180697    4780            20185                  115993
       9208
pyperf180.bpf.linked3.o                    on_event
    118245    8422            17797                   36579
       2881
test_verif_scale1.bpf.linked3.o            balancer_ingress
    546742    8636            16439                   43048
        270
test_verif_scale3.bpf.linked3.o            balancer_ingress
    837487    8636            16439                   43048
        270
xdp_synproxy_kern.bpf.linked3.o            syncookie_xdp
     85116    5162            15308                   30910
         65
xdp_synproxy_kern.bpf.linked3.o            syncookie_tc
     82848    5107            15239                   30812
         66
strobemeta_nounroll2.bpf.linked3.o         on_event
    104119    3820            12128                   72765
       3388
test_cls_redirect.bpf.linked3.o            cls_redirect
     65594    4230            11683                   18353
         50
pyperf100.bpf.linked3.o                    on_event
     72685    5123            11208                   23467
       1630
test_cls_redirect_subprogs.bpf.linked3.o   cls_redirect
     57790    4063             9711                   17719
         93
loop3.bpf.linked3.o                        while_true
   1000001    9663             9663                  111106
     111111
test_verif_scale2.bpf.linked3.o            balancer_ingress
    767498    3048             9144                   21812
         90
strobemeta_subprogs.bpf.linked3.o          on_event
     52685    1653             5890                   40180
       1636
pyperf50.bpf.linked3.o                     on_event
     36980    2623             5708                   11967
        880
strobemeta_nounroll1.bpf.linked3.o         on_event
     49337    1706             5522                   32940
       1552
loop1.bpf.linked3.o                        nested_loops
    361349    5504             5504                   90288
      90300
pyperf_subprogs.bpf.linked3.o              on_event
     36029    2526             5425                   11195
        890

SELFTESTS AFTER
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[vmuser@archvm bpf]$ sudo veristat -e
file,prog,insns,states,jmp_allocs,jmp_total,jmp_peak -R
~/insn-hist-after-results-selftests.csv -s jmp_allocs -n 20
File                                       Program
      Insns  States  Jumphist allocs  Jumphist total entries  Jumphist
peak entries
-----------------------------------------
------------------------------  -------  ------  ---------------
----------------------  ---------------------
pyperf600_nounroll.bpf.linked3.o           on_event
     533132   34227            67332                  260526
       18282
pyperf600.bpf.linked3.o                    on_event
     475837   22259            48488                  183880
       13455
verifier_loops1.bpf.linked3.o
loop_after_a_conditional_jump   1000001   25000            25000
            25001                  25002
strobemeta.bpf.linked3.o                   on_event
     176036    4734            19835                  147680
       13666
pyperf180.bpf.linked3.o                    on_event
     118245    8422            17797                   50683
        3763
test_verif_scale1.bpf.linked3.o            balancer_ingress
     546742    8636            16439                   43048
         270
test_verif_scale3.bpf.linked3.o            balancer_ingress
     837487    8636            16439                   43048
         270
xdp_synproxy_kern.bpf.linked3.o            syncookie_tc
      81241    5155            15347                   46763
         148
xdp_synproxy_kern.bpf.linked3.o            syncookie_xdp
      82297    5157            15321                   49715
         148
strobemeta_nounroll2.bpf.linked3.o         on_event
     104119    3820            12128                   80924
        3724
test_cls_redirect.bpf.linked3.o            cls_redirect
      65401    4212            11662                   24862
          79
pyperf100.bpf.linked3.o                    on_event
      72685    5123            11208                   36290
        3201
test_cls_redirect_subprogs.bpf.linked3.o   cls_redirect
      57790    4063             9711                   24814
         146
loop3.bpf.linked3.o                        while_true
    1000001    9663             9663                  333321
      333335
test_verif_scale2.bpf.linked3.o            balancer_ingress
     767498    3048             9144                   28787
         180
strobemeta_subprogs.bpf.linked3.o          on_event
      52685    1653             5890                   45798
        1776
pyperf50.bpf.linked3.o                     on_event
      36980    2623             5708                   18175
        1691
strobemeta_nounroll1.bpf.linked3.o         on_event
      49337    1706             5522                   38476
        1718
loop1.bpf.linked3.o                        nested_loops
     361349    5504             5504                   90288
       90300
pyperf_subprogs.bpf.linked3.o              on_event
      36029    2526             5425                   18130
        1885


Stats counting diff:

$ git show -- kernel
commit febebc9586c08820fa927b1628454b2709e98e3f (HEAD)
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Thu Nov 9 11:02:40 2023 -0800

    [EXPERIMENT] bpf: add jump/insns history stats

    Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b688043e5460..d0f25f36221e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2026,6 +2026,10 @@ static int pop_stack(struct bpf_verifier_env
*env, int *prev_insn_idx,
                return -ENOENT;

        if (cur) {
+               env->jmp_hist_peak =3D max(env->jmp_hist_peak,
cur->insn_hist_end);
+               env->jmp_hist_total +=3D cur->insn_hist_end -
cur->insn_hist_start;
+               env->jmp_hist_allocs +=3D 1;
+
                err =3D copy_verifier_state(cur, &head->st);
                if (err)
                        return err;
@@ -3648,6 +3653,8 @@ static int push_jmp_history(struct bpf_verifier_env *=
env,
        p->idx =3D env->insn_idx;
        p->prev_idx =3D env->prev_insn_idx;
        cur->insn_hist_end++;
+
+       env->jmp_hist_peak =3D max(env->jmp_hist_peak, cur->insn_hist_end);
        return 0;
 }

@@ -17205,6 +17212,9 @@ static int is_state_visited(struct
bpf_verifier_env *env, int insn_idx)
        WARN_ONCE(new->branches !=3D 1,
                  "BUG is_state_visited:branches_to_explore=3D%d insn
%d\n", new->branches, insn_idx);

+       env->jmp_hist_total +=3D cur->insn_hist_end - cur->insn_hist_start;
+       env->jmp_hist_allocs +=3D 1;
+
        cur->parent =3D new;
        cur->first_insn_idx =3D insn_idx;
        cur->insn_hist_start =3D cur->insn_hist_end;
@@ -20170,10 +20180,12 @@ static void print_verification_stats(struct
bpf_verifier_env *env)
                verbose(env, "\n");
        }
        verbose(env, "processed %d insns (limit %d) max_states_per_insn %d =
"
-               "total_states %d peak_states %d mark_read %d\n",
+               "total_states %d peak_states %d mark_read %d "
+               "jmp_allocs %d jmp_total %d jmp_peak %d\n",
                env->insn_processed, BPF_COMPLEXITY_LIMIT_INSNS,
                env->max_states_per_insn, env->total_states,
-               env->peak_states, env->longest_mark_read_walk);
+               env->peak_states, env->longest_mark_read_walk,
+               env->jmp_hist_allocs, env->jmp_hist_total, env->jmp_hist_pe=
ak);
 }

