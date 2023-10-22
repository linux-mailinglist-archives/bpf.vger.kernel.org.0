Return-Path: <bpf+bounces-12918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 924397D20FE
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 06:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 521021C2090E
	for <lists+bpf@lfdr.de>; Sun, 22 Oct 2023 04:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09015EDA;
	Sun, 22 Oct 2023 04:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V49lxwIX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE663A57
	for <bpf@vger.kernel.org>; Sun, 22 Oct 2023 04:28:25 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2195291
	for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 21:28:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso320979366b.2
        for <bpf@vger.kernel.org>; Sat, 21 Oct 2023 21:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697948902; x=1698553702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICRqySWQQUV+m52y3I7okYqdptO2j8XQ7+sCRsztzVk=;
        b=V49lxwIXYscw9jedPEf5tDMTVUk5S5Tvs8GvOII6u2dBf2Zdn8ObHwQBA38IOKYADu
         T85je1JwiCVg8XdroMWgCb+fCzeU3xuHFXfDEQt5Isf6PejVGAVXoLrHkOsbhAD10vdK
         CwF3tWDIIbpkpQzEjEHRv0F+UCVXi6FXC+HXFCDiSQIEXSxcNBVsX2P+6cdCHExE8Nwq
         NmbHLx3hSaIM4pi8NEdBYi1eeNc9FoljQilFDWnjTWTEnzyc1UXMa8wdEGta68lYC3kP
         Z0c5cv2LqrVuhKlTTKIi9joX83o6dkRx0tRikrW584HUneKYczi2M+JxIuBwIU0BPOhg
         VAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697948902; x=1698553702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICRqySWQQUV+m52y3I7okYqdptO2j8XQ7+sCRsztzVk=;
        b=eeSEBh3EpgKIa2atGiLnWAfM2VXfXnldT0/nyZtl5tCh7ZWPDsnV1ImTMa4IwnOY6e
         M4z/gsBgwCVv6n+1jrd1qn3U+qRZb1eG2p24nuI2PH0UOZEEUqfpWKoyBAZ4yickBsX4
         1JFP7YvtLAQDfHnzkDreC8cyT6FD9sxnU/7+NHhRI297JK3QlKGO9WVNtEMWNW4mJeaT
         +5P2IrTd/IKohVttBUFCQ6Ch7LV6qMWSFsxfS2YFYYPZCjHLR7fhIyZ1q4hjJF6YbfUS
         AhRgZJnTudL5z8nLk4NYdZrCyeAT6UhrxZSB3rlvS7YifIZq0f9suLfhOMi1ciddX5Jy
         TVYA==
X-Gm-Message-State: AOJu0YyHmVjNaFgUq4ZfxPNtRuvgljjKKM2kSzeNXKPIEQXY6Y95ZQL3
	Gz5cPaCvbKYKzaBc5I9oKhrpM/T7O/Hg5cwMZ+w=
X-Google-Smtp-Source: AGHT+IFpDyv4uny3o0KTNhvZtH0IJJtsiTDGRtCi9II+WqNQVqDTYMbvbuv9ZstTNhLWtSvIy+fqcf23kKFhL4bBf3w=
X-Received: by 2002:a17:907:26c9:b0:9c7:59d1:b2c2 with SMTP id
 bp9-20020a17090726c900b009c759d1b2c2mr5573084ejc.27.1697948902312; Sat, 21
 Oct 2023 21:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231022010812.9201-1-eddyz87@gmail.com> <20231022010812.9201-6-eddyz87@gmail.com>
In-Reply-To: <20231022010812.9201-6-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Sat, 21 Oct 2023 21:28:11 -0700
Message-ID: <CAEf4BzZwEx3P+u+J_4P1trf6=ChQ7cQWEkDjZ2aNLQzoNhz1jA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/7] bpf: correct loop detection for iterators convergence
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com, 
	john.fastabend@gmail.com, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 21, 2023 at 6:08=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> It turns out that .branches > 0 in is_state_visited() is not a
> sufficient condition to identify if two verifier states form a loop
> when iterators convergence is computed. This commit adds logic to
> distinguish situations like below:
>
>  (I)            initial       (II)            initial
>                   |                             |
>                   V                             V
>      .---------> hdr                           ..
>      |            |                             |
>      |            V                             V
>      |    .------...                    .------..
>      |    |       |                     |       |
>      |    V       V                     V       V
>      |   ...     ...               .-> hdr     ..
>      |    |       |                |    |       |
>      |    V       V                |    V       V
>      |   succ <- cur               |   succ <- cur
>      |    |                        |    |
>      |    V                        |    V
>      |   ...                       |   ...
>      |    |                        |    |
>      '----'                        '----'
>
> For both (I) and (II) successor 'succ' of the current state 'cur' was
> previously explored and has branches count at 0. However, loop entry
> 'hdr' corresponding to 'succ' might be a part of current DFS path.
> If that is the case 'succ' and 'cur' are members of the same loop
> and have to be compared exactly.
>
> Co-developed-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Co-developed-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  15 +++
>  kernel/bpf/verifier.c        | 207 ++++++++++++++++++++++++++++++++++-
>  2 files changed, 218 insertions(+), 4 deletions(-)
>

LGTM, but see the note below about state being its own loop_entry. It
feels like a bit better approach would be to use "loop_entry_ref_cnt"
instead of just a bool used_as_loop_entry, and do a proper accounting
when child state is freed and when propagating loop_entries. But
perhaps that can be done in a follow up, if you think it's a good
idea.

Reviewed-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 38b788228594..24213a99cc79 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[...]

> + * To adapt this algorithm for use with verifier:
> + * - use st->branch =3D=3D 0 as a signal that DFS of succ had been finis=
hed
> + *   and cur's loop entry has to be updated (case A), handle this in
> + *   update_branch_counts();
> + * - use st->branch > 0 as a signal that st is in the current DFS path;
> + * - handle cases B and C in is_state_visited();
> + * - update topmost loop entry for intermediate states in get_loop_entry=
().
> + */
> +static struct bpf_verifier_state *get_loop_entry(struct bpf_verifier_sta=
te *st)
> +{
> +       struct bpf_verifier_state *topmost =3D st->loop_entry, *old;
> +
> +       while (topmost && topmost->loop_entry && topmost !=3D topmost->lo=
op_entry)
> +               topmost =3D topmost->loop_entry;
> +       /* Update loop entries for intermediate states to avoid this
> +        * traversal in future get_loop_entry() calls.
> +        */
> +       while (st && st->loop_entry !=3D topmost) {
> +               old =3D st->loop_entry;
> +               st->loop_entry =3D topmost;
> +               st =3D old;
> +       }
> +       return topmost;
> +}
> +
> +static void update_loop_entry(struct bpf_verifier_state *cur, struct bpf=
_verifier_state *hdr)
> +{
> +       struct bpf_verifier_state *cur1, *hdr1;
> +
> +       cur1 =3D get_loop_entry(cur) ?: cur;
> +       hdr1 =3D get_loop_entry(hdr) ?: hdr;
> +       /* The head1->branches check decides between cases B and C in
> +        * comment for get_loop_entry(). If hdr1->branches =3D=3D 0 then
> +        * head's topmost loop entry is not in current DFS path,
> +        * hence 'cur' and 'hdr' are not in the same loop and there is
> +        * no need to update cur->loop_entry.
> +        */
> +       if (hdr1->branches && hdr1->dfs_depth <=3D cur1->dfs_depth) {
> +               cur->loop_entry =3D hdr;
> +               hdr->used_as_loop_entry =3D true;
> +       }
> +}
> +
>  static void update_branch_counts(struct bpf_verifier_env *env, struct bp=
f_verifier_state *st)
>  {
>         while (st) {
>                 u32 br =3D --st->branches;
>
> +               /* br =3D=3D 0 signals that DFS exploration for 'st' is f=
inished,
> +                * thus it is necessary to update parent's loop entry if =
it
> +                * turned out that st is a part of some loop.
> +                * This is a part of 'case A' in get_loop_entry() comment=
.
> +                */
> +               if (br =3D=3D 0 && st->parent && st->loop_entry)
> +                       update_loop_entry(st->parent, st->loop_entry);
> +
>                 /* WARN_ON(br > 1) technically makes sense here,
>                  * but see comment in push_stack(), hence:
>                  */
> @@ -16649,10 +16815,11 @@ static int is_state_visited(struct bpf_verifier=
_env *env, int insn_idx)
>  {
>         struct bpf_verifier_state_list *new_sl;
>         struct bpf_verifier_state_list *sl, **pprev;
> -       struct bpf_verifier_state *cur =3D env->cur_state, *new;
> +       struct bpf_verifier_state *cur =3D env->cur_state, *new, *loop_en=
try;
>         int i, j, err, states_cnt =3D 0;
>         bool force_new_state =3D env->test_state_freq || is_force_checkpo=
int(env, insn_idx);
>         bool add_new_state =3D force_new_state;
> +       bool force_exact;
>
>         /* bpf progs typically have pruning point every 4 instructions
>          * http://vger.kernel.org/bpfconf2019.html#session-1
> @@ -16747,8 +16914,10 @@ static int is_state_visited(struct bpf_verifier_=
env *env, int insn_idx)
>                                          */
>                                         spi =3D __get_spi(iter_reg->off +=
 iter_reg->var_off.value);
>                                         iter_state =3D &func(env, iter_re=
g)->stack[spi].spilled_ptr;
> -                                       if (iter_state->iter.state =3D=3D=
 BPF_ITER_STATE_ACTIVE)
> +                                       if (iter_state->iter.state =3D=3D=
 BPF_ITER_STATE_ACTIVE) {
> +                                               update_loop_entry(cur, &s=
l->state);
>                                                 goto hit;
> +                                       }
>                                 }
>                                 goto skip_inf_loop_check;
>                         }
> @@ -16779,7 +16948,36 @@ static int is_state_visited(struct bpf_verifier_=
env *env, int insn_idx)
>                                 add_new_state =3D false;
>                         goto miss;
>                 }
> -               if (states_equal(env, &sl->state, cur, false)) {
> +               /* If sl->state is a part of a loop and this loop's entry=
 is a part of
> +                * current verification path then states have to be compa=
red exactly.
> +                * 'force_exact' is needed to catch the following case:
> +                *
> +                *                initial     Here state 'succ' was proce=
ssed first,
> +                *                  |         it was eventually tracked t=
o produce a
> +                *                  V         state identical to 'hdr'.
> +                *     .---------> hdr        All branches from 'succ' ha=
d been explored
> +                *     |            |         and thus 'succ' has its .br=
anches =3D=3D 0.
> +                *     |            V
> +                *     |    .------...        Suppose states 'cur' and 's=
ucc' correspond
> +                *     |    |       |         to the same instruction + c=
allsites.
> +                *     |    V       V         In such case it is necessar=
y to check
> +                *     |   ...     ...        if 'succ' and 'cur' are sta=
tes_equal().
> +                *     |    |       |         If 'succ' and 'cur' are a p=
art of the
> +                *     |    V       V         same loop exact flag has to=
 be set.
> +                *     |   succ <- cur        To check if that is the cas=
e, verify
> +                *     |    |                 if loop entry of 'succ' is =
in current
> +                *     |    V                 DFS path.
> +                *     |   ...
> +                *     |    |
> +                *     '----'
> +                *
> +                * Additional details are in the comment before get_loop_=
entry().
> +                */
> +               loop_entry =3D get_loop_entry(&sl->state);
> +               force_exact =3D loop_entry && loop_entry->branches > 0;
> +               if (states_equal(env, &sl->state, cur, force_exact)) {
> +                       if (force_exact)
> +                               update_loop_entry(cur, loop_entry);
>  hit:
>                         sl->hit_cnt++;
>                         /* reached equivalent register/stack state,
> @@ -16825,7 +17023,8 @@ static int is_state_visited(struct bpf_verifier_e=
nv *env, int insn_idx)
>                          * speed up verification
>                          */
>                         *pprev =3D sl->next;
> -                       if (sl->state.frame[0]->regs[0].live & REG_LIVE_D=
ONE) {
> +                       if (sl->state.frame[0]->regs[0].live & REG_LIVE_D=
ONE &&
> +                           !sl->state.used_as_loop_entry) {

In get_loop_entry() you have an additional `topmost !=3D
topmost->loop_entry` check, suggesting that state can be its own
loop_entry. Can that happen? And if yes, should we account for that
here?


>                                 u32 br =3D sl->state.branches;
>
>                                 WARN_ONCE(br,
> --
> 2.42.0
>

