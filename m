Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E397550AB7B
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 00:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442452AbiDUW3s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 18:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384054AbiDUW3r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 18:29:47 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12894A90B
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 15:26:56 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id r8so2988927vkq.4
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 15:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cu5jy/zKXjRcq3mf8g0iqSIlw/rWo64T2L1TFJMZ7YI=;
        b=qgfM1xiA/ovt0Wfc6A2sniv4hzzWGLAnWFUniGCSrhPVvDET3JeT+CRWgBL8gLE75J
         2B8cWPGuB5dtaYInapGWcqRz93ShCZ5RvsvhdyBgxYk66/bQcVc0XmQ7wcT8DCC7sozn
         W7Tdnyufip2h+6ZK9Ai8itEtU/bv3XjTQ+yv6F5irzsx3Vw0At32coQjp+msRpL4etNA
         mIwtXXqvQ04RqqSWZ31UJY27WK33WdeZZDpG2C6XplggTISI3kvc5pJRR8sIshiCLqrf
         BwVRjEl27RdYjtBA/DbJrqvcfraVISFGBqzaXTKvABSthvJ/95Jlkgm1TLaF9o4+2fTo
         iJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cu5jy/zKXjRcq3mf8g0iqSIlw/rWo64T2L1TFJMZ7YI=;
        b=AMMn5dcN0TcT1JAT0dp4e6jSiWamIQzvOaJFXEwH9QytlahGxgPhd6qWBCz0HMLf09
         znBIUPN0V+RqzSV7f9+Nfz5oSMrONfru3Ma8MMRJFhe0ltCRGfSIy3COJQnop5uabypT
         MAWbSg0geX7FoQGDblb/1e8z4bcITYUQjyH9147eLjabU3dLOfGzl5KJ8lVw/J2q/DMg
         Hf/2hVhhM+Ec79SYA3oX6WaA6R/hhrV5gzb5BvaBW4PT2nKlneAaTFVB2eWpl5J4El5B
         9ejqNK7eDLr+SkQD0Gowh5i2h4ndzF5ritqHd7LPIK7RQWKpvkom/lWgSVsBN8QPlOv8
         teFA==
X-Gm-Message-State: AOAM5309AmvFoyKPfoAnyqCI6fck00NRYsppiLcQ4fmu1HRtB6/m+fw8
        6VVPqMSx4OlISkJ1Y3KsQ7zeJ0DHpcZgFzH7+p0=
X-Google-Smtp-Source: ABdhPJwzFgg9SNWheVbcLet5lqB1v/a2QMxIfNA922Lz4AQ5k6N7/wHRSyVLWiVpRxlGk/Biu19Q9tbdXiqV9fA4bX8=
X-Received: by 2002:a1f:9dca:0:b0:349:6bb2:1c1a with SMTP id
 g193-20020a1f9dca000000b003496bb21c1amr542246vke.1.1650580015848; Thu, 21 Apr
 2022 15:26:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220415160354.1050687-1-memxor@gmail.com> <20220415160354.1050687-4-memxor@gmail.com>
 <20220421041528.eez5euhgsm5dvjwz@MBP-98dd607d3435.dhcp.thefacebook.com> <20220421193621.3rk7rys7gjtjdhw7@apollo.legion>
In-Reply-To: <20220421193621.3rk7rys7gjtjdhw7@apollo.legion>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 21 Apr 2022 15:26:44 -0700
Message-ID: <CAADnVQLntQ7zVXXHZBpL_1H+ph8Evtcng-yG5QP5tfq5sYdHnw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 03/13] bpf: Allow storing unreferenced kptr in map
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 21, 2022 at 12:36 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> > > +
> > > +   if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, reg->off,
> > > +                             off_desc->kptr.btf, off_desc->kptr.btf_id))
> > > +           goto bad_type;
> >
> > Is full type comparison really needed?
>
> Yes.
>
> > reg->btf should be the same pointer as off_desc->kptr.btf
> > and btf_id should match exactly.
>
> This is not true, it can be vmlinux or module BTF. But if you mean just
> comparing the pointer and btf_id, we still need to handle reg->off.
>
> We want to support cases like:
>
> struct foo {
>         struct bar br;
>         struct baz bz;
> };
>
> struct foo *v = func(); // PTR_TO_BTF_ID
> map->foo = v;      // reg->off is zero, btf and btf_id matches type.
> map->bar = &v->br; // reg->off is still zero, but we need to walk and retry with
>                    // first member type of struct after comparison fails.
> map->baz = &v->bz; // reg->off is non-zero, so struct needs to be walked to
>                    // match type.
>
> In the ref case, the argument's offset will always be 0, so third case is not
> going to work, but in the unref case, we want to allow storing pointers to
> structs embedded inside parent struct.
>
> Please let me know if I misunderstood what you meant.

Makes sense.
Please add this comment to the code.

> > Is this a feature proofing for some day when registers with PTR_TO_BTF_ID type
> > will start pointing to prog's btf?
> >
> > > +   return 0;
> > > +bad_type:
> > > +   verbose(env, "invalid kptr access, R%d type=%s%s ", regno,
> > > +           reg_type_str(env, reg->type), reg_name);
> > > +   verbose(env, "expected=%s%s\n", reg_type_str(env, PTR_TO_BTF_ID), targ_name);
> > > +   return -EINVAL;
> > > +}
> > > +
> > > +static int check_map_kptr_access(struct bpf_verifier_env *env, u32 regno,
> > > +                            int value_regno, int insn_idx,
> > > +                            struct bpf_map_value_off_desc *off_desc)
> > > +{
> > > +   struct bpf_insn *insn = &env->prog->insnsi[insn_idx];
> > > +   int class = BPF_CLASS(insn->code);
> > > +   struct bpf_reg_state *val_reg;
> > > +
> > > +   /* Things we already checked for in check_map_access and caller:
> > > +    *  - Reject cases where variable offset may touch kptr
> > > +    *  - size of access (must be BPF_DW)
> > > +    *  - tnum_is_const(reg->var_off)
> > > +    *  - off_desc->offset == off + reg->var_off.value
> > > +    */
> > > +   /* Only BPF_[LDX,STX,ST] | BPF_MEM | BPF_DW is supported */
> > > +   if (BPF_MODE(insn->code) != BPF_MEM) {
> > > +           verbose(env, "kptr in map can only be accessed using BPF_MEM instruction mode\n");
> > > +           return -EACCES;
> > > +   }
> > > +
> > > +   if (class == BPF_LDX) {
> > > +           val_reg = reg_state(env, value_regno);
> > > +           /* We can simply mark the value_regno receiving the pointer
> > > +            * value from map as PTR_TO_BTF_ID, with the correct type.
> > > +            */
> > > +           mark_btf_ld_reg(env, cur_regs(env), value_regno, PTR_TO_BTF_ID, off_desc->kptr.btf,
> > > +                           off_desc->kptr.btf_id, PTR_MAYBE_NULL);
> > > +           val_reg->id = ++env->id_gen;
> >
> > why non zero id this needed?
>
> For mark_ptr_or_null_reg. I'll add a comment.

Ahh. It's because it's not a plain PTR_TO_BTF_ID,
but the one with PTR_MAYBE_NULL.
Makes sense.
