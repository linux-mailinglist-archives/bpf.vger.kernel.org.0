Return-Path: <bpf+bounces-8144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF8E782356
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 07:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 581061C20843
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 05:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB6F17FE;
	Mon, 21 Aug 2023 05:57:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D472A15B6
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 05:57:30 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E922EB4
	for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 22:57:24 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-64f457c97a3so1318676d6.2
        for <bpf@vger.kernel.org>; Sun, 20 Aug 2023 22:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692597444; x=1693202244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n17+LCNcj4uo1JrCSUBgx6KBebj2Y6kS0pvppTsz+qU=;
        b=THTWFrkwvjR4oTsqwr5LIf+Mv5daMLwH9WtMAT9VNi5c4kObnkyz4uiSUf7DTr+3va
         q9v6ZTFBDny8Ir8mMUxI9Z1XxgGvCocxaSbLBfuSk7ybyZ557kMxCen3WILyS7oik0J2
         bI6GASMJacF2tAm7yYPmctHwCTis/2K+3qQRjBlauGaZKyJjYXN4a4n28yT0AYMgm9ka
         qdvZrVLmxMXmeVBq0j/M8qb+iMEJMwH9AgR+RPRgROnRj/KXDSM0CFxlm1U/ItCgLXTw
         ajT6IsNozgvW2OFXePbyKvQeDzNsjiG1/Jgd/lV82tA2vxlI6wFC3sk2O77mlAHrxnzv
         KqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692597444; x=1693202244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n17+LCNcj4uo1JrCSUBgx6KBebj2Y6kS0pvppTsz+qU=;
        b=h9TKN8KwEcAZKavwI1nIIXpBZR/ZnK/0q1jo0PjcXolsuVUYfx7zSvPVh+Xn2UPKJy
         H8oGfz64NuHAWGr33Rr+321FQPDz4K/pfKb9A9wSD4e9MGO5Gj+1s35Sa5p71yFc8YcE
         74BIF/bbK8YEtW/Fv8ZatjcChLOoVRcSuIcZSwEljgYl66uQTqG/ZVOgF+PTG2L6z0YW
         nh+kebBiIXVkBlwWm3Glc2Aes6q2S/CbpNvE52ffrs8XCJ3mXI9HgGZLClXAgos3qtPY
         bRzFQwBAdwS6wjJjXw9iGnCbHmJFeFv7d6PjjarPl+uJhWhGjYpdmlvbuqqt/AfsWECd
         uU6g==
X-Gm-Message-State: AOJu0Yzpgz86ykDdfsAZFGfPmhZPqwaQJ37Xn5bsSNQC+k5jz7NYzGt6
	kgi5mESuGF3v2K9B0ixG0N6kdHCWIifJpuPD9J8=
X-Google-Smtp-Source: AGHT+IGpW34x1M8DCvK1OPkql0kYUKHgPDzE9Rzg91ZbFTvmHnGnHF4fyAYV3YMwN/SeQAwFqI9K1SgOsRuFx27Y9DY=
X-Received: by 2002:a0c:b292:0:b0:63c:f5c0:cd14 with SMTP id
 r18-20020a0cb292000000b0063cf5c0cd14mr6186715qve.49.1692597443953; Sun, 20
 Aug 2023 22:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814143341.3767-1-laoar.shao@gmail.com> <20230814143341.3767-2-laoar.shao@gmail.com>
 <56dc2449-f01c-f0a7-e31b-cfe6cd157aaa@linux.dev> <CALOAHbC9cka4Ma7KWOjGtFkjshU214z9NMaYXHiOTfc7dc7=tQ@mail.gmail.com>
 <CAADnVQJ1ddz9H4GQmegb4QMHk0cq_hXvK_r+MaLLssV7XtNY2g@mail.gmail.com>
 <CALOAHbDO-mdehzkojC_ZHnfoty=RrEr2ehYT7-qj1mzSpw-6aA@mail.gmail.com>
 <CAADnVQ+Nmspr7Si+pxWn8zkE7hX-7s93ugwC+94aXSy4uQ9vBg@mail.gmail.com>
 <CALOAHbDF=h9Piyx3BERNjK7Y_n6+qPefDvs+pFyZb5H2SmCkhQ@mail.gmail.com> <91d1017f-0c08-6db7-8696-63bd95c2b8a0@iogearbox.net>
In-Reply-To: <91d1017f-0c08-6db7-8696-63bd95c2b8a0@iogearbox.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 21 Aug 2023 13:56:47 +0800
Message-ID: <CALOAHbDDT=paFEdTb1Jsqu7eGkFXAh6A+f21VTrMdAeq5F60kg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Add bpf_current_capable kfunc
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 11:30=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 8/17/23 9:09 AM, Yafang Shao wrote:
> > On Thu, Aug 17, 2023 at 11:31=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> On Wed, Aug 16, 2023 at 7:31=E2=80=AFPM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> >>> On Thu, Aug 17, 2023 at 9:54=E2=80=AFAM Alexei Starovoitov
> >>> <alexei.starovoitov@gmail.com> wrote:
> >>>> On Mon, Aug 14, 2023 at 7:46=E2=80=AFPM Yafang Shao <laoar.shao@gmai=
l.com> wrote:
> >>>>> On Tue, Aug 15, 2023 at 8:28=E2=80=AFAM Yonghong Song <yonghong.son=
g@linux.dev> wrote:
> >>>>>> On 8/14/23 7:33 AM, Yafang Shao wrote:
> >>>>>>> Add a new bpf_current_capable kfunc to check whether the current =
task
> >>>>>>> has a specific capability. In our use case, we will use it in a l=
sm bpf
> >>>>>>> program to help identify if the user operation is permitted.
> >>>>>>>
> >>>>>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >>>>>>> ---
> >>>>>>>    kernel/bpf/helpers.c | 6 ++++++
> >>>>>>>    1 file changed, 6 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >>>>>>> index eb91cae..bbee7ea 100644
> >>>>>>> --- a/kernel/bpf/helpers.c
> >>>>>>> +++ b/kernel/bpf/helpers.c
> >>>>>>> @@ -2429,6 +2429,11 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
> >>>>>>>        rcu_read_unlock();
> >>>>>>>    }
> >>>>>>>
> >>>>>>> +__bpf_kfunc bool bpf_current_capable(int cap)
> >>>>>>> +{
> >>>>>>> +     return has_capability(current, cap);
> >>>>>>> +}
> >>>>>>
> >>>>>> Since you are testing against 'current' capabilities, I assume
> >>>>>> that the context should be process. Otherwise, you are testing
> >>>>>> against random task which does not make much sense.
> >>>>>
> >>>>> It is in the process context.
> >>>>>
> >>>>>> Since you are testing against 'current' cap, and if the capability
> >>>>>> for that task is stable, you do not need this kfunc.
> >>>>>> You can test cap in user space and pass it into the bpf program.
> >>>>>>
> >>>>>> But if the cap for your process may change in the middle of
> >>>>>> run, then you indeed need bpf prog to test capability in real time=
.
> >>>>>> Is this your use case and could you describe in in more detail?
> >>>>>
> >>>>> After we convert the capability of our networking bpf program from
> >>>>> CAP_SYS_ADMIN to CAP_BPF+CAP_NET_ADMIN to enhance the security, we
> >>>>> encountered the "pointer comparison prohibited" error, because
> >>>>> allow_ptr_leaks is enabled only when CAP_PERFMON is set. However, i=
f
> >>>>> we enable the CAP_PERFMON for the networking bpf program, it can ru=
n
> >>>>> tracing bpf prog, perf_event bpf prog and etc, that is not expected=
 by
> >>>>> us.
> >>>>>
> >>>>> Hence we are planning to use a lsm bpf program to disallow it from
> >>>>> running other bpf programs. In our lsm bpf program we will check th=
e
> >>>>> capability of processes, if the process has cap_net_admin, cap_bpf =
and
> >>>>> cap_perfmon but don't have cap_sys_admin we will refuse it to run
> >>>>> tracing and perf_event bpf program. While if a process has  cap_bpf
> >>>>> and cap_perfmon but doesn't have cap_net_admin, that said it is a b=
pf
> >>>>> program which wants to run trace bpf, we will allow it.
> >>>>>
> >>>>> We can't use lsm_cgroup because it is supported on cgroup2 only, wh=
ile
> >>>>> we're still using cgroup1.
> >>>>>
> >>>>> Another possible solution is enable allow_ptr_leaks for cap_net_adm=
in
> >>>>> as well, but after I checked the commit which introduces the cap_bp=
f
> >>>>> and cap_perfmon [1], I think we wouldn't like to do it.
> >>>>
> >>>> Sorry. None of these options are acceptable.
> >>>>
> >>>> The idea of introducing a bpf_current_capable() kfunc just to work
> >>>> around a deficiency in the verifier is not sound.
> >>>
> >>> So what should we do then?
> >>> Just enabling the cap_perfmon for it? That does not sound as well ...
> >>
> >> Yonghong already pointed out upthread that
> >> comparison of two packet pointers is not a pointer leak.
> >> See this code:
> >>          } else if (!try_match_pkt_pointers(insn, dst_reg, &regs[insn-=
>src_reg],
> >>                                             this_branch, other_branch)=
 &&
> >>                     is_pointer_value(env, insn->dst_reg)) {
> >>                  verbose(env, "R%d pointer comparison prohibited\n",
> >>                          insn->dst_reg);
> >>                  return -EACCES;
> >>          }
> >>
> >> It's not clear why it doesn't address your case.
> >
> > It can address the issue.
> > It seems we should do the code change below.
>
> I presume in your actual program you also access the IP header (otherwise=
 it
> would be quite useless), and as you mentioned above, you would like this =
to be
> accessible for just CAP_BPF + CAP_NET_ADMIN. The CAP_PERFMON restriction =
is
> there for a reason, that is, to be on same cap level as tracing programs =
as you
> could craft Spectre v1 style access. It's not a deficiency.

Hi Daniel,

We also hit an error caused by bpf_bypass_spec_v1 in our
networking-bpf with cap_net_admin+cap_bpf.

Here is a simple reproducer,

#include <linux/pkt_cls.h>
#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/tcp.h>
#include <linux/bpf.h>

#include <bpf/bpf_helpers.h>

struct flow_stats_v {
    __u32 egress_packets;
    __u32 ingress_packets;
};

/* ELF map definition */
struct bpf_elf_map {
    __u32 type;
    __u32 size_key;
    __u32 size_value;
    __u32 max_elem;
    __u32 flags;
    __u32 id;
    __u32 pinning;
    __u32 inner_id;
    __u32 inner_idx;
};

struct bpf_elf_map SEC("maps") flow_stats =3D {
    .type =3D BPF_MAP_TYPE_HASH,
    .size_key =3D sizeof(__u32),
    .size_value =3D sizeof(struct flow_stats_v),
    .max_elem =3D 32,
    .flags =3D BPF_F_NO_PREALLOC,
    .pinning =3D 0,
};

struct bpf_elf_map SEC("maps") classid =3D {
    .type =3D BPF_MAP_TYPE_HASH,
    .size_key =3D sizeof(__be32),
    .size_value =3D sizeof(__be32),
    .max_elem =3D 32,
    .flags =3D BPF_F_NO_PREALLOC,
    .pinning =3D 0,
};

struct flow {
    __be32 local_classid;
    __be32 local_addr;
    __u8 dir;
};

static void flow_stat(struct __sk_buff *skb, struct flow *flow)
{
        struct flow_stats_v *value;
        __u32 key =3D 0; // This value is not relavant

        value =3D bpf_map_lookup_elem(&flow_stats, &key);
        if (!value)
                return;

        if (flow->dir =3D=3D 0)
                __sync_fetch_and_add(&value->egress_packets, 1);
        else
                __sync_fetch_and_add(&value->ingress_packets, 1);
}

int handle_packet(struct __sk_buff *skb, int dir)
{
        void *data_end =3D (void *)(long)skb->data_end;
        void *data =3D (void *)(long)skb->data;
        struct flow flow =3D {};
        __be32 *id;

        flow.dir =3D dir;
        flow.local_addr =3D 1; // This value is not relavant

        id =3D bpf_map_lookup_elem(&classid, &flow.local_addr);
        if (id && *id)
                flow.local_classid =3D *id;

        flow_stat(skb, &flow);
        return TC_ACT_OK;
}

SEC("cls-ingress")
int ingress(struct __sk_buff *skb)
{
        return handle_packet(skb, 1);
}

char _license[] SEC("license") =3D "GPL";


The error log of the bpf verifier as follows,

23: (71) r3 =3D *(u8 *)(r10 -8)         ;
R3_w=3Dscalar(umax=3D255,var_off=3D(0x0; 0xff)) R10=3Dfp0 fp-8=3Dmmmm???m
24: (b7) r2 =3D 1                       ; R2_w=3D1
25: (55) if r3 !=3D 0x0 goto pc+1 27:
R0=3Dmap_value(off=3D0,ks=3D4,vs=3D8,imm=3D0) R1_w=3D1 R2_w=3D1
R3_w=3Dscalar(umax=3D255,var_off=3D(0x0; 0xff)) R10=3Dfp0 fp-8=3Dmmmm???m f=
p-16=3D
27: (67) r2 <<=3D 2                     ; R2_w=3D4
28: (0f) r0 +=3D r2
R0 tried to add from different maps, paths or scalars, pointer
arithmetic with it prohibited for !root
processed 31 insns (limit 1000000000) max_states_per_insn 0
total_states 3 peak_states 3 mark_read 1

It can be fixed by the code change below in the kernel,

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b6b60cd..0e200a9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11750,7 +11750,7 @@ static int update_alu_sanitation_state(struct
bpf_insn_aux_data *aux,
        /* If we arrived here from different branches with different
         * state or limits to sanitize, then this won't work.
         */
-       if (aux->alu_state &&
+       if (aux->alu_state && aux->alu_limit &&
            (aux->alu_state !=3D alu_state ||
             aux->alu_limit !=3D alu_limit))
                return REASON_PATHS;

But I'm not sure if it is a proper fix.

We can workaround the issue by modifying our bpf program as follows,

@@ -77,7 +77,21 @@ int handle_packet(struct __sk_buff *skb, int dir)
        if (id && *id)
                flow.local_classid =3D *id;

-       flow_stat(skb, &flow);
+       {
+       struct flow_stats_v *value;
+       __u32 key =3D 0; // This value is not relavant
+
+       value =3D bpf_map_lookup_elem(&flow_stats, &key);
+       if (!value)
+               return TC_ACT_OK;
+
+       if (flow.dir =3D=3D 0)
+               __sync_fetch_and_add(&value->egress_packets, 1);
+       else
+               __sync_fetch_and_add(&value->ingress_packets, 1);
+
+       }
+       // flow_stat(skb, &flow);
        return TC_ACT_OK;
 }

But I don't have a clear idea why.
It seems to me that the bpf verifier under cap_net_admin+cap_bpf is
fragile.  I'm wondering if it is possible to add a sysctl to bypass
the perfmon check :

--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2091,22 +2091,22 @@ static inline void
bpf_map_dec_elem_count(struct bpf_map *map)

 static inline bool bpf_allow_ptr_leaks(void)
 {
-       return perfmon_capable();
+       return perfmon_capable() || syscal_bypass_perfmon;
 }

 static inline bool bpf_allow_uninit_stack(void)
 {
-       return perfmon_capable();
+       return perfmon_capable() || syscal_bypass_perfmon;
 }

 static inline bool bpf_bypass_spec_v1(void)
 {
-       return perfmon_capable();
+       return perfmon_capable() || syscal_bypass_perfmon;
 }

 static inline bool bpf_bypass_spec_v4(void)
 {
-       return perfmon_capable();
+       return perfmon_capable() || syscal_bypass_perfmon;
 }

 int bpf_map_new_fd(struct bpf_map *map, int flags);

Do you have any suggestions?

--=20
Regards
Yafang

