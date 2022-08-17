Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14705979C1
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 00:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238965AbiHQWlu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 18:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238969AbiHQWlt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 18:41:49 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7659AFA5
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 15:41:48 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d20so13225377pfq.5
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 15:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=m9wDPDxb6XekBaY8loSTpi/hiI8hk0Bl/kHHW2V1vTk=;
        b=g3s7VjhqKxvqU3lgDTGWTtV3o8rZTbxxoBn9IFsStQJ/6RUrNw2bKfPa2ZqfKwYQWP
         Nix+FnOjGGVm6l10H0yoEKsw0HeoA20VD2wWn3W0hxaIaYF6veJWGrZqcxmSJBOVTD21
         QZEwe1Q8hB72ZFP7AWq6LQw95AqYxHsUR6vE7QpDrID0lnN6F4RISIOh+4wvgT8xein5
         TttQJkV8Vwtu6FKFhus5ZXW0Pc/vLb+0Se8LyAi7JxP+W9iUinUYcXzULsAphYe13DKz
         /RbLJbGjK+4Qg9TN6hGbfqa9H7ex7afuzT1t0z+9VADQlJA66mUpkNxy8nzUkNItsIwf
         BXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=m9wDPDxb6XekBaY8loSTpi/hiI8hk0Bl/kHHW2V1vTk=;
        b=iF/AakhmoRYMV8KDGCpjP5HvLk/8G1x08YYqmTVxVCPNPvRqOpR4L3R0tLQd79gyF3
         ita8apmnNpbZnQFyd/v1iNUz8sb7QF7wQ1V3CLEwXMuuRBZwU/WjHpx/z7z1V3+1FpQx
         Jt3Giu8qIr+2SdSoKY1AyyMs98GoqMb/XDhrd39aAMgAt6pDvNYanUZnxB5YAjfzEiCB
         v+7OVDiONt5t7Ph/e/E6SwDbsOqji0FDlhUt0a1KMv3pTeLTKHGOeiv7G0DanuvyyEgo
         lUx2vau/cr77Q4hePjLZrVLbd65XTlimVkt3WnhI49fH0tkCxYWyrowZj2LXfEpQO+7C
         dIiw==
X-Gm-Message-State: ACgBeo1IvpI6knVieNy8O9XbEcZTUeBtBYCk/KVW9yKMEkUrAD0xcVbQ
        dJEzUMbGSATzkdPl7qAJpXufUrtywu7FX7jyntOa4Q==
X-Google-Smtp-Source: AA6agR6H+y3M5KyCOWIsGNS4iT+vbaacKOH2V7dOrvzfsV5NFAztQhJ0Umv9CBPRaNEvWppcgE1n7u3tbaM37LyDINo=
X-Received: by 2002:a62:1d86:0:b0:52d:9df0:2151 with SMTP id
 d128-20020a621d86000000b0052d9df02151mr286484pfd.33.1660776108237; Wed, 17
 Aug 2022 15:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220816201214.2489910-1-sdf@google.com> <20220816201214.2489910-2-sdf@google.com>
 <20220817192235.u3e45w2wmnxt4xlb@kafai-mbp>
In-Reply-To: <20220817192235.u3e45w2wmnxt4xlb@kafai-mbp>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 17 Aug 2022 15:41:36 -0700
Message-ID: <CAKH8qBsD5joerhv+igMWs94S-H=5ED_+9WHZM+CX72G6y2yu_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Introduce cgroup_{common,current}_func_proto
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 17, 2022 at 12:22 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, Aug 16, 2022 at 01:12:12PM -0700, Stanislav Fomichev wrote:
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index a627a02cf8ab..c302d2de073a 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1948,6 +1948,10 @@ struct bpf_prog *bpf_prog_by_id(u32 id);
> >  struct bpf_link *bpf_link_by_id(u32 id);
> >
> >  const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id);
> > +const struct bpf_func_proto *
> > +cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
> > +const struct bpf_func_proto *
> > +cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
> >  void bpf_task_storage_free(struct task_struct *task);
> >  bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
> >  const struct btf_func_model *
> > @@ -2154,6 +2158,18 @@ bpf_base_func_proto(enum bpf_func_id func_id)
> >       return NULL;
> >  }
> >
> > +static inline const struct bpf_func_proto *
> > +cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> > +{
> > +     return NULL;
> > +}
> > +
> > +static inline const struct bpf_func_proto *
> > +cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> > +{
> > +     return NULL;
> > +}
> > +
> There two new functions are implemented in cgroup.c which only compiles with
> CONFIG_CGROUP_BPF.  I think the change in bpf.h here should be done in
> bpf-cgroup.h instead.  Otherwise, the changes in filter.c in the next patch will
> have issue in resolving these functions when CONFIG_CGROUP_BPF is not set.

SG. Let me try. I think I have a config for CONFIG_CGROUPS=y
CONFIG_CGROUP_BPF=n, but maybe I don't, let me check.

> > -#define BPF_STRTOX_BASE_MASK 0x1F
> > -
> > -static int __bpf_strtoull(const char *buf, size_t buf_len, u64 flags,
> > -                       unsigned long long *res, bool *is_negative)
> > -{
> > -     unsigned int base = flags & BPF_STRTOX_BASE_MASK;
> > -     const char *cur_buf = buf;
> > -     size_t cur_len = buf_len;
> > -     unsigned int consumed;
> > -     size_t val_len;
> > -     char str[64];
> > -
> > -     if (!buf || !buf_len || !res || !is_negative)
> > -             return -EINVAL;
> > -
> > -     if (base != 0 && base != 8 && base != 10 && base != 16)
> > -             return -EINVAL;
> > -
> > -     if (flags & ~BPF_STRTOX_BASE_MASK)
> > -             return -EINVAL;
> > -
> > -     while (cur_buf < buf + buf_len && isspace(*cur_buf))
> > -             ++cur_buf;
> > -
> > -     *is_negative = (cur_buf < buf + buf_len && *cur_buf == '-');
> > -     if (*is_negative)
> > -             ++cur_buf;
> > -
> > -     consumed = cur_buf - buf;
> > -     cur_len -= consumed;
> > -     if (!cur_len)
> > -             return -EINVAL;
> > -
> > -     cur_len = min(cur_len, sizeof(str) - 1);
> > -     memcpy(str, cur_buf, cur_len);
> > -     str[cur_len] = '\0';
> > -     cur_buf = str;
> > -
> > -     cur_buf = _parse_integer_fixup_radix(cur_buf, &base);
> > -     val_len = _parse_integer(cur_buf, base, res);
> > -
> > -     if (val_len & KSTRTOX_OVERFLOW)
> > -             return -ERANGE;
> > -
> > -     if (val_len == 0)
> > -             return -EINVAL;
> > -
> > -     cur_buf += val_len;
> > -     consumed += cur_buf - str;
> > -
> > -     return consumed;
> > -}
> > -
> > -static int __bpf_strtoll(const char *buf, size_t buf_len, u64 flags,
> > -                      long long *res)
> > -{
> > -     unsigned long long _res;
> > -     bool is_negative;
> > -     int err;
> > -
> > -     err = __bpf_strtoull(buf, buf_len, flags, &_res, &is_negative);
> > -     if (err < 0)
> > -             return err;
> > -     if (is_negative) {
> > -             if ((long long)-_res > 0)
> > -                     return -ERANGE;
> > -             *res = -_res;
> > -     } else {
> > -             if ((long long)_res < 0)
> > -                     return -ERANGE;
> > -             *res = _res;
> > -     }
> > -     return err;
> > -}
> > -
> > -BPF_CALL_4(bpf_strtol, const char *, buf, size_t, buf_len, u64, flags,
> > -        long *, res)
> > -{
> > -     long long _res;
> > -     int err;
> > -
> > -     err = __bpf_strtoll(buf, buf_len, flags, &_res);
> > -     if (err < 0)
> > -             return err;
> > -     if (_res != (long)_res)
> > -             return -ERANGE;
> > -     *res = _res;
> > -     return err;
> > -}
> > -
> > -const struct bpf_func_proto bpf_strtol_proto = {
> > -     .func           = bpf_strtol,
> > -     .gpl_only       = false,
> > -     .ret_type       = RET_INTEGER,
> > -     .arg1_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
> > -     .arg2_type      = ARG_CONST_SIZE,
> > -     .arg3_type      = ARG_ANYTHING,
> > -     .arg4_type      = ARG_PTR_TO_LONG,
> > -};
> > -
> > -BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
> > -        unsigned long *, res)
> > -{
> > -     unsigned long long _res;
> > -     bool is_negative;
> > -     int err;
> > -
> > -     err = __bpf_strtoull(buf, buf_len, flags, &_res, &is_negative);
> > -     if (err < 0)
> > -             return err;
> > -     if (is_negative)
> > -             return -EINVAL;
> > -     if (_res != (unsigned long)_res)
> > -             return -ERANGE;
> > -     *res = _res;
> > -     return err;
> > -}
> > -
> > -const struct bpf_func_proto bpf_strtoul_proto = {
> This should be useful in general other than cgroup bpf.
> It may end up moving back to helpers.c soon.
> How about take this chance to add it to bpf_base_func_proto()
> which already has another string helper bpf_strncmp_proto?

Sure, will do! Thanks!


> > -     .func           = bpf_strtoul,
> > -     .gpl_only       = false,
> > -     .ret_type       = RET_INTEGER,
> > -     .arg1_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
> > -     .arg2_type      = ARG_CONST_SIZE,
> > -     .arg3_type      = ARG_ANYTHING,
> > -     .arg4_type      = ARG_PTR_TO_LONG,
> > -};
> > -#endif
