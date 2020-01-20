Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC621428E1
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2020 12:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgATLJ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jan 2020 06:09:56 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34178 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgATLJ4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jan 2020 06:09:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id w5so14477942wmi.1
        for <bpf@vger.kernel.org>; Mon, 20 Jan 2020 03:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RspWDOuWB94i7/kbi7JammXa2EW0J7yWnKwQFB9cKlM=;
        b=P8NpeW3AeZuEVz1jzbkL4MKGPOrL4M6IoO7+omC7PffznVE2d1lCJnOXNeIrcaYUsK
         jrzuhj7R3li5vMlT0ntHsE2GUWJHdxa1v6aJWcoEGmFdYBnoYPdbcoGBiPLPNVNLMebT
         8ZohB3jfFbzXsC0alSRXzSAHBMmQh6q8MFaJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RspWDOuWB94i7/kbi7JammXa2EW0J7yWnKwQFB9cKlM=;
        b=c9Y3mgbCmqnamS0txOvsBh25CFqh6QyUE0PQx0e/VEPLTo8G15AWKfXAuyoB6xqg6B
         TZY8MKFLfLSGLxSrh3C1caq7gAJWZ6GR+D061YHWUzKtSNagS6FOIxf0lMydjZZn5alG
         oLr8ehr+7VHUVc+6ibBelvQEWVArflCVh6gfBcnvhdWYW0nnANMySSw8PF678jVMuRhG
         ntSLYNCCw7I6rnT7MV4Xm9KH4hXpQjBTMuBwvQDiQQAm/+P2KGK4w+ZHbRp9aJAkIuFu
         m5SYUEeTeOLwmnxDTeT87E9DZW3BNyAjaZ7UiXayx9R8kp5N0oBL2pPbWnCnjImycl6v
         vMrQ==
X-Gm-Message-State: APjAAAUYyIxcFjyU0fVCjqh1U62y9ruXACvIAbA8CLH4kgK+sR8ZaTic
        9Rl8HymfCIDOfOKqEPXQoU9tGw==
X-Google-Smtp-Source: APXvYqyDk4jizH/XUJGSaGOPu6EqrnnUUjF7Yly9Etd4JBrzZfrlvh8zaBDXhks0HUetnI71eaCagQ==
X-Received: by 2002:a1c:f009:: with SMTP id a9mr18379484wmb.73.1579518592324;
        Mon, 20 Jan 2020 03:09:52 -0800 (PST)
Received: from chromium.org ([2620:0:105f:fd00:24a7:c82b:86d8:5ae9])
        by smtp.gmail.com with ESMTPSA id l15sm45167551wrv.39.2020.01.20.03.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 03:09:51 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Mon, 20 Jan 2020 12:10:14 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Garnier <thgarnie@chromium.org>,
        Michael Halcrow <mhalcrow@google.com>,
        Paul Turner <pjt@google.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Jann Horn <jannh@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Christian Brauner <christian@brauner.io>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>, Joe Stringer <joe@wand.net.nz>
Subject: Re: [PATCH bpf-next v2 05/10] bpf: lsm: BTF API for LSM hooks
Message-ID: <20200120111014.GB26394@chromium.org>
References: <20200115171333.28811-1-kpsingh@chromium.org>
 <20200115171333.28811-6-kpsingh@chromium.org>
 <CAEf4BzYJy40csmwfBgtD+UZY3X+hjqpQ=NwjUQ-cwy+RPF8VHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYJy40csmwfBgtD+UZY3X+hjqpQ=NwjUQ-cwy+RPF8VHA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks for reviewing!

On 16-Jan 16:28, Andrii Nakryiko wrote:
> On Wed, Jan 15, 2020 at 9:14 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > The BTF API provides information required by the BPF verifier to
> > attach eBPF programs to the LSM hooks by using the BTF information of
> > two types:
> >
> > - struct security_hook_heads: This type provides the offset which
> >   a new dynamically allocated security hook must be attached to.
> > - union security_list_options: This provides the information about the
> >   function prototype required by the hook.
> >
> > When the program is loaded:
> >
> > - The verifier receives the index of a member in struct
> >   security_hook_heads to which a program must be attached as
> >   prog->aux->lsm_hook_index. The index is one-based for better
> >   verification.
> > - bpf_lsm_type_by_index is used to determine the func_proto of
> >   the LSM hook and updates prog->aux->attach_func_proto
> > - bpf_lsm_head_by_index is used to determine the hlist_head to which
> >   the BPF program must be attached.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  include/linux/bpf_lsm.h |  12 +++++
> >  security/bpf/Kconfig    |   1 +
> >  security/bpf/hooks.c    | 104 ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 117 insertions(+)
> >
> > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > index 9883cf25241c..a9b4f7b41c65 100644
> > --- a/include/linux/bpf_lsm.h
> > +++ b/include/linux/bpf_lsm.h
> > @@ -19,6 +19,8 @@ extern struct security_hook_heads bpf_lsm_hook_heads;
> >
> >  int bpf_lsm_srcu_read_lock(void);
> >  void bpf_lsm_srcu_read_unlock(int idx);
> > +const struct btf_type *bpf_lsm_type_by_index(struct btf *btf, u32 offset);
> > +const struct btf_member *bpf_lsm_head_by_index(struct btf *btf, u32 id);
> >
> >  #define CALL_BPF_LSM_VOID_HOOKS(FUNC, ...)                     \
> >         do {                                                    \
> > @@ -65,6 +67,16 @@ static inline int bpf_lsm_srcu_read_lock(void)
> >         return 0;
> >  }
> >  static inline void bpf_lsm_srcu_read_unlock(int idx) {}
> > +static inline const struct btf_type *bpf_lsm_type_by_index(
> > +       struct btf *btf, u32 index)
> > +{
> > +       return ERR_PTR(-EOPNOTSUPP);
> > +}
> > +static inline const struct btf_member *bpf_lsm_head_by_index(
> > +       struct btf *btf, u32 id)
> > +{
> > +       return ERR_PTR(-EOPNOTSUPP);
> > +}
> >
> >  #endif /* CONFIG_SECURITY_BPF */
> >
> > diff --git a/security/bpf/Kconfig b/security/bpf/Kconfig
> > index 595e4ad597ae..9438d899b618 100644
> > --- a/security/bpf/Kconfig
> > +++ b/security/bpf/Kconfig
> > @@ -7,6 +7,7 @@ config SECURITY_BPF
> >         depends on SECURITY
> >         depends on BPF_SYSCALL
> >         depends on SRCU
> > +       depends on DEBUG_INFO_BTF
> >         help
> >           This enables instrumentation of the security hooks with
> >           eBPF programs.
> > diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
> > index b123d9cb4cd4..82725611693d 100644
> > --- a/security/bpf/hooks.c
> > +++ b/security/bpf/hooks.c
> > @@ -5,6 +5,8 @@
> >   */
> >
> >  #include <linux/bpf_lsm.h>
> > +#include <linux/bpf.h>
> > +#include <linux/btf.h>
> >  #include <linux/srcu.h>
> >
> >  DEFINE_STATIC_SRCU(security_hook_srcu);
> > @@ -18,3 +20,105 @@ void bpf_lsm_srcu_read_unlock(int idx)
> >  {
> >         return srcu_read_unlock(&security_hook_srcu, idx);
> >  }
> > +
> > +static inline int validate_hlist_head(struct btf *btf, u32 type_id)
> > +{
> > +       s32 hlist_id;
> > +
> > +       hlist_id = btf_find_by_name_kind(btf, "hlist_head", BTF_KIND_STRUCT);
> > +       if (hlist_id < 0 || hlist_id != type_id)
> > +               return -EINVAL;
> 
> This feels backwards and expensive. You already have type_id you want
> to check. Do a quick look up, check type and other attributes, if you
> want. There is no need to do linear search for struct named
> "hlist_head".
> 
> But in reality, you should trust kernel BTF, you already know that you
> found correct "security_hook_heads" struct, so its member has to be
> hlist_head, no?

We had a discussion internally and also came the same conclusion (it's
okay to trust the BTF) and will remove sone of the "over-cautious"
checks in the next revision.

This one, however, in particular is to protect against the case when a
new member which is not a hlist_head is added to security_hook_heads
and the user-space tries to attach at that index.

I admit that the likelyhood of that happening is very little  but I
think it's worth checking. I do, like your idea and will update the
code to use the type_id and do a quick check rather than a linear
search to look for the type_id.

This is what remains of all the pedantic checks pertaining to
hlist_head:

	t = btf_type_by_id(btf, member->type);
	if (unlikely(!t))
		return -EINVAL;

	if (BTF_INFO_KIND(t->info) != BTF_KIND_STRUCT)
		return -EINVAL;

	if (t->size != sizeof(struct hlist_head))
		return -EINVAL;

> 
> > +
> > +       return 0;
> > +}
> > +
> > +/* Find the BTF representation of the security_hook_heads member for a member
> > + * with a given index in struct security_hook_heads.
> > + */
> > +const struct btf_member *bpf_lsm_head_by_index(struct btf *btf, u32 index)
> > +{
> > +       const struct btf_member *member;
> > +       const struct btf_type *t;
> > +       u32 off, i;
> > +       int ret;
> > +
> > +       t = btf_type_by_name_kind(btf, "security_hook_heads", BTF_KIND_STRUCT);
> > +       if (WARN_ON_ONCE(IS_ERR(t)))
> > +               return ERR_CAST(t);
> > +
> > +       for_each_member(i, t, member) {
> > +               /* We've found the id requested and need to check the

> > +                * the following:
> > +                *
> > +                * - Is it at a valid alignment for struct hlist_head?
> > +                *
> > +                * - Is it a valid hlist_head struct?
> > +                */
> > +               if (index == i) {
> 
> Also not efficient. Check index to be < vlen(t), then member =
> btf_type_member(t) + index;

Neat! Updated.

> 
> 
> > +                       off = btf_member_bit_offset(t, member);
> > +                       if (off % 8)
> > +                               /* valid c code cannot generate such btf */
> > +                               return ERR_PTR(-EINVAL);
> > +                       off /= 8;
> > +
> > +                       if (off % __alignof__(struct hlist_head))
> > +                               return ERR_PTR(-EINVAL);
> > +
> > +                       ret = validate_hlist_head(btf, member->type);
> > +                       if (ret < 0)
> > +                               return ERR_PTR(ret);
> > +
> > +                       return member;
> 
> This feels a bit over-cautious to double-check this. If
> security_hook_heads definition is controlled by kernel sources, then
> we could just trust vmlinux BTF?

Yep, makes sense. Removed some of these checks.

> 
> > +               }
> > +       }
> > +
> > +       return ERR_PTR(-ENOENT);
> > +}
> > +
> > +/* Given an index of a member in security_hook_heads return the
> > + * corresponding type for the LSM hook. The members of the union
> > + * security_list_options have the same name as the security_hook_heads which
> > + * is ensured by the LSM_HOOK_INIT macro defined in include/linux/lsm_hooks.h
> > + */
> > +const struct btf_type *bpf_lsm_type_by_index(struct btf *btf, u32 index)
> > +{
> > +       const struct btf_member *member, *hook_head = NULL;
> > +       const struct btf_type *t, *hook_type = NULL;
> > +       u32 i;
> > +
> > +       hook_head = bpf_lsm_head_by_index(btf, index);
> > +       if (IS_ERR(hook_head))
> > +               return ERR_PTR(PTR_ERR(hook_head));
> > +
> > +       t = btf_type_by_name_kind(btf, "security_list_options", BTF_KIND_UNION);
> > +       if (WARN_ON_ONCE(IS_ERR(t)))
> > +               return ERR_CAST(t);
> 
> btf_type_by_name_kind() is a linear search (at least right now), so it
> might be a good idea to cache found type_id's of security_list_options
> and security_hook_heads?

I am already caching these types in the next patch (struct
bpf_lsm_info) of the series which implements attachment. I moved it to
this patch so that it's clearer.

> 
> > +
> > +       for_each_member(i, t, member) {
> > +               if (hook_head->name_off == member->name_off) {
> > +                       /* There should be only one member with the same name
> > +                        * as the LSM hook. This should never really happen
> > +                        * and either indicates malformed BTF or someone trying
> > +                        * trick the LSM.
> > +                        */
> > +                       if (WARN_ON(hook_type))
> > +                               return ERR_PTR(-EINVAL);
> > +
> > +                       hook_type = btf_type_by_id(btf, member->type);
> > +                       if (unlikely(!hook_type))
> > +                               return ERR_PTR(-EINVAL);
> > +
> > +                       if (!btf_type_is_ptr(hook_type))
> > +                               return ERR_PTR(-EINVAL);
> > +               }
> > +       }
> > +
> > +       if (!hook_type)
> > +               return ERR_PTR(-ENOENT);
> > +
> > +       t = btf_type_by_id(btf, hook_type->type);
> > +       if (unlikely(!t))
> > +               return ERR_PTR(-EINVAL);
> 
> why not do this inside the loop when you find correct member and not
> continue processing all the fields?

Updated.

- KP

> 
> > +
> > +       return t;
> > +}
> > --
> > 2.20.1
> >
