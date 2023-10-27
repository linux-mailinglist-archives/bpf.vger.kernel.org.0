Return-Path: <bpf+bounces-13433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC667D9ED3
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 19:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687142824F1
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 17:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8D42F37;
	Fri, 27 Oct 2023 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ecSxUd6n"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12CE39867
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 17:24:51 +0000 (UTC)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D202FAB
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 10:24:49 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5a86b6391e9so17983347b3.0
        for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 10:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1698427489; x=1699032289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Za9e5Dh/4QheDvhTWG1blgAX1sntB8GoxogcjDHf4KA=;
        b=ecSxUd6ntwbhNRICYob7KgeH+2BIPGPk/51EyO9Fnrlz0uGTMrlepKwvJM/Fc0Zt/H
         UQDnqXDkX6idZr4mNoD/YMm3A6qDUYYyjtHFcdyhQPjVtQVWcpI8StNO5BYYntgHygbc
         NVuuOMaALD47ypQlJMPnCZHkQuQ56Z67kMh/Z9yNP9lmvNDgtkn8RcqZM9mZjUawaQGW
         PlHAk3dS7vLeK01lTBuDKLzWEjOiotj4jvkmvixcPa0ckjlp08sN48z0LE3xZ3SeFJgV
         bim03silzoieFmj7l5dmvPgqF1zSpTOPNXaMJVNb1gXZzfGJJaT5fHG28LhiRou9tGfe
         7IgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698427489; x=1699032289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Za9e5Dh/4QheDvhTWG1blgAX1sntB8GoxogcjDHf4KA=;
        b=dtLY6Axh27XZyqPOMZeVGwq1Q1OfkdC/ZHqVZ38Y1IonwX01cd2Cmf9WkXB5j/9c7J
         2rolR+u+Nxx4pu9ubiZYyUG9CYjmVJ3QPJ4cCXxzR7jnoFQt92U8l092GWLJH078lkKN
         5cvseM5EJuGEx/VuYwyEFuOD3fPWmX0H6QFrG6bSNpia8PtEjdfQfZCYSoJUtdoVppvJ
         2d3RTTDYewjyUhbYp469iPIi34PUneRoc/m6RohbrwsfV0vuKUkbJPt8MFHY8ORmJC+i
         JFSNROvFGn1wCj20IJ+sXPVGgc30Yhlr/UmU54g8VmgRfR1hHY4hBGXCX2SOMg10MDDQ
         frWg==
X-Gm-Message-State: AOJu0YyRLP1Vglr03pzePTkUWMyC9HIaAOtUZxCoWHLQiTMpcA49wfRA
	Z/wfnpP+DqGlVXnM4zq6EKkICBnasYKu+0FXqcwzJg==
X-Google-Smtp-Source: AGHT+IHcuu7sO7dg/XgOLhNsoEhg+OKa5f6/8kEPQoIT7JshSd7rY6W4bBRm0yDC1jVpUadifHW/d6Y58/QRUpp4/Lk=
X-Received: by 2002:a81:9955:0:b0:5a8:1654:4b6f with SMTP id
 q82-20020a819955000000b005a816544b6fmr3178720ywg.17.1698427488962; Fri, 27
 Oct 2023 10:24:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231027135142.11555-1-daniel@iogearbox.net>
In-Reply-To: <20231027135142.11555-1-daniel@iogearbox.net>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 27 Oct 2023 13:24:37 -0400
Message-ID: <CAM0EoMm9K=jS=JZUNXo+C6qs=p=r7CtjWK20ocmTKEDxN3Bz-w@mail.gmail.com>
Subject: Re: [PATCH net-next] net, sched: Fix SKB_NOT_DROPPED_YET splat under
 debug config
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, idosch@idosch.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 9:51=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Ido reported:
>
>   [...] getting the following splat [1] with CONFIG_DEBUG_NET=3Dy and thi=
s
>   reproducer [2]. Problem seems to be that classifiers clear 'struct
>   tcf_result::drop_reason', thereby triggering the warning in
>   __kfree_skb_reason() due to reason being 'SKB_NOT_DROPPED_YET' (0). [..=
.]
>
>   [1]
>   WARNING: CPU: 0 PID: 181 at net/core/skbuff.c:1082 kfree_skb_reason+0x3=
8/0x130
>   Modules linked in:
>   CPU: 0 PID: 181 Comm: mausezahn Not tainted 6.6.0-rc6-custom-ge43e6d958=
2e0 #682
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-1.fc=
37 04/01/2014
>   RIP: 0010:kfree_skb_reason+0x38/0x130
>   [...]
>   Call Trace:
>    <IRQ>
>    __netif_receive_skb_core.constprop.0+0x837/0xdb0
>    __netif_receive_skb_one_core+0x3c/0x70
>    process_backlog+0x95/0x130
>    __napi_poll+0x25/0x1b0
>    net_rx_action+0x29b/0x310
>    __do_softirq+0xc0/0x29b
>    do_softirq+0x43/0x60
>    </IRQ>
>
>   [2]
>   #!/bin/bash
>
>   ip link add name veth0 type veth peer name veth1
>   ip link set dev veth0 up
>   ip link set dev veth1 up
>   tc qdisc add dev veth1 clsact
>   tc filter add dev veth1 ingress pref 1 proto all flower dst_mac 00:11:2=
2:33:44:55 action drop
>   mausezahn veth0 -a own -b 00:11:22:33:44:55 -q -c 1
>
> What happens is that inside most classifiers the tcf_result is copied ove=
r
> from a filter template e.g. *res =3D f->res which then implicitly overrid=
es
> the prior SKB_DROP_REASON_TC_{INGRESS,EGRESS} default drop code which was
> set via sch_handle_{ingress,egress}() for kfree_skb_reason().
>
> Add a small helper tcf_set_result() and convert classifiers over to it.
> The latter leaves the drop code intact and classifiers, actions as well
> as the action engine in tcf_exts_exec() can then in future make use of
> tcf_set_drop_reason(), too.
>
> Tested that the splat is fixed under CONFIG_DEBUG_NET=3Dy with the repro.
>
> Fixes: 54a59aed395c ("net, sched: Make tc-related drop reason more flexib=
le")
> Reported-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/netdev/ZTjY959R+AFXf3Xy@shredder
> ---
>  include/net/pkt_cls.h    | 12 ++++++++++++
>  net/sched/cls_basic.c    |  2 +-
>  net/sched/cls_bpf.c      |  2 +-
>  net/sched/cls_flower.c   |  2 +-
>  net/sched/cls_fw.c       |  2 +-
>  net/sched/cls_matchall.c |  2 +-
>  net/sched/cls_route.c    |  4 ++--
>  net/sched/cls_u32.c      |  2 +-
>  8 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
> index a76c9171db0e..31d8e8587824 100644
> --- a/include/net/pkt_cls.h
> +++ b/include/net/pkt_cls.h
> @@ -160,6 +160,18 @@ static inline void tcf_set_drop_reason(struct tcf_re=
sult *res,
>         res->drop_reason =3D reason;
>  }
>
> +static inline void tcf_set_result(struct tcf_result *to,
> +                                 const struct tcf_result *from)
> +{
> +       /* tcf_result's drop_reason which is the last member must be
> +        * preserved and cannot be copied from the cls'es tcf_result
> +        * template given this is carried all the way and potentially
> +        * set to a concrete tc drop reason upon error or intentional
> +        * drop. See tcf_set_drop_reason() locations.
> +        */
> +       memcpy(to, from, offsetof(typeof(*to), drop_reason));
> +}
>

I believe our bigger issue here is we are using this struct now for
both policy set by the control plane and for runtime decisions
(drop_reason) - whereas the original assumption was this struct only
held set policy. In retrospect we should have put the verdict(which is
policy) here and return the error code (as was in the first patch). I
am also not sure humans would not make a mistake on "this field must
be at the end of the struct". Can we put some assert (or big comment
on the struct) to make sure someone does not overwrite this field?
Also what happens if "from" above has a set drop_reason - is that
lost? Do you need an assert there as well?
BTW: The simple patch i posted fixes the problem as well (i actually
tested it minus the typo i sent).

cheers,
jamal


>  static inline void
>  __tcf_bind_filter(struct Qdisc *q, struct tcf_result *r, unsigned long b=
ase)
>  {
> diff --git a/net/sched/cls_basic.c b/net/sched/cls_basic.c
> index 1b92c33b5f81..d7ead3fc3c45 100644
> --- a/net/sched/cls_basic.c
> +++ b/net/sched/cls_basic.c
> @@ -50,7 +50,7 @@ TC_INDIRECT_SCOPE int basic_classify(struct sk_buff *sk=
b,
>                 if (!tcf_em_tree_match(skb, &f->ematches, NULL))
>                         continue;
>                 __this_cpu_inc(f->pf->rhit);
> -               *res =3D f->res;
> +               tcf_set_result(res, &f->res);
>                 r =3D tcf_exts_exec(skb, &f->exts, res);
>                 if (r < 0)
>                         continue;
> diff --git a/net/sched/cls_bpf.c b/net/sched/cls_bpf.c
> index 382c7a71f81f..e4620a462bc3 100644
> --- a/net/sched/cls_bpf.c
> +++ b/net/sched/cls_bpf.c
> @@ -124,7 +124,7 @@ TC_INDIRECT_SCOPE int cls_bpf_classify(struct sk_buff=
 *skb,
>                         res->class   =3D 0;
>                         res->classid =3D filter_res;
>                 } else {
> -                       *res =3D prog->res;
> +                       tcf_set_result(res, &prog->res);
>                 }
>
>                 ret =3D tcf_exts_exec(skb, &prog->exts, res);
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index e5314a31f75a..eb94090fb26c 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -341,7 +341,7 @@ TC_INDIRECT_SCOPE int fl_classify(struct sk_buff *skb=
,
>
>                 f =3D fl_mask_lookup(mask, &skb_key);
>                 if (f && !tc_skip_sw(f->flags)) {
> -                       *res =3D f->res;
> +                       tcf_set_result(res, &f->res);
>                         return tcf_exts_exec(skb, &f->exts, res);
>                 }
>         }
> diff --git a/net/sched/cls_fw.c b/net/sched/cls_fw.c
> index c49d6af0e048..70b873f8771f 100644
> --- a/net/sched/cls_fw.c
> +++ b/net/sched/cls_fw.c
> @@ -63,7 +63,7 @@ TC_INDIRECT_SCOPE int fw_classify(struct sk_buff *skb,
>                 for (f =3D rcu_dereference_bh(head->ht[fw_hash(id)]); f;
>                      f =3D rcu_dereference_bh(f->next)) {
>                         if (f->id =3D=3D id) {
> -                               *res =3D f->res;
> +                               tcf_set_result(res, &f->res);
>                                 if (!tcf_match_indev(skb, f->ifindex))
>                                         continue;
>                                 r =3D tcf_exts_exec(skb, &f->exts, res);
> diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
> index c4ed11df6254..a4018db80a60 100644
> --- a/net/sched/cls_matchall.c
> +++ b/net/sched/cls_matchall.c
> @@ -37,7 +37,7 @@ TC_INDIRECT_SCOPE int mall_classify(struct sk_buff *skb=
,
>         if (tc_skip_sw(head->flags))
>                 return -1;
>
> -       *res =3D head->res;
> +       tcf_set_result(res, &head->res);
>         __this_cpu_inc(head->pf->rhit);
>         return tcf_exts_exec(skb, &head->exts, res);
>  }
> diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
> index 1424bfeaca73..cbfaa1d1820f 100644
> --- a/net/sched/cls_route.c
> +++ b/net/sched/cls_route.c
> @@ -109,7 +109,7 @@ static inline int route4_hash_wild(void)
>
>  #define ROUTE4_APPLY_RESULT()                                  \
>  {                                                              \
> -       *res =3D f->res;                                          \
> +       tcf_set_result(res, &f->res);                           \
>         if (tcf_exts_has_actions(&f->exts)) {                   \
>                 int r =3D tcf_exts_exec(skb, &f->exts, res);      \
>                 if (r < 0) {                                    \
> @@ -152,7 +152,7 @@ TC_INDIRECT_SCOPE int route4_classify(struct sk_buff =
*skb,
>                         goto failure;
>                 }
>
> -               *res =3D f->res;
> +               tcf_set_result(res, &f->res);
>                 spin_unlock(&fastmap_lock);
>                 return 0;
>         }
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index 6663e971a13e..f50ae40a29d5 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -172,7 +172,7 @@ TC_INDIRECT_SCOPE int u32_classify(struct sk_buff *sk=
b,
>  check_terminal:
>                         if (n->sel.flags & TC_U32_TERMINAL) {
>
> -                               *res =3D n->res;
> +                               tcf_set_result(res, &n->res);
>                                 if (!tcf_match_indev(skb, n->ifindex)) {
>                                         n =3D rcu_dereference_bh(n->next)=
;
>                                         goto next_knode;
> --
> 2.34.1
>

