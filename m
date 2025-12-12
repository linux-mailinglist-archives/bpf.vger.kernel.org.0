Return-Path: <bpf+bounces-76534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0E7CB8EF8
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 14:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F5933071FA9
	for <lists+bpf@lfdr.de>; Fri, 12 Dec 2025 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82F427145F;
	Fri, 12 Dec 2025 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="vxDyszaG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C74B21CC60
	for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765547865; cv=none; b=lthLK2WYK0VuCcXilENg/X3Mo+GVzFmoRb+CihrM0SWx6/JtME3S2Gq7hFF01cInQ8JFJNoR+y4IRnXd92Cn+NUix+EvbxMiJlZhoHjmHag8bvDwGW8OciXoOlN8jb+o2jgIUPg52+ji8IvzxcM39FdJHRyPgVyKEfRE13AsK4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765547865; c=relaxed/simple;
	bh=icrGdMhjDIagrBu2lgFtkezTQ8WVqwRjwGBoeApRRc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUyDokAWuPAakpIo3vp9ug7ewJK3aAIidAochXoG07+QDmJcmJH3WmxhpoGROUZWSmq6ZvwadSxIOYqN11o7C3KMtDsaD2qHKj6MnQTcfHlpcdFZuW7gqXHkSB+GzDEXyB9PMYGzSfPHyV3YlT1GcXrfyO2yl/xARCJ+I67kpwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=vxDyszaG; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37d13ddaa6aso8624691fa.1
        for <bpf@vger.kernel.org>; Fri, 12 Dec 2025 05:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1765547861; x=1766152661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiHiQxteOsa7hHrqGiFGJT3ihKG7RV3tZB23jXSBDsQ=;
        b=vxDyszaGBZnDbJrj9mXu1QArgLXc2gxenLFFvcZdO0KuWyGDjrvw2xX+VPOr9bzk5p
         Lz+Jdsb//LaalBSJ8c0tl3Yki2yC1j5uTghJ1agGMGgPFObECQzZLdUXCkeTX1ySPAX9
         5BWCx1Xj8UhwgKTIh2ca2gGXdmCJ5si4Rwxj95zYgVLIu9PevLBst6h9ifFY5T3X9OKG
         qD5mLWThyiy/qFHTHTZolpsbfBAcz7vy6bJbZMXzOj/ks0YnF3v4XA0puZ62Z+Akobws
         pjleJQCeYemzrP6TorBcIrYmG8MDNyF59MCM6ULPF1rxNB55RY94t69f1Yl+JuQxLMfl
         Mdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765547861; x=1766152661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BiHiQxteOsa7hHrqGiFGJT3ihKG7RV3tZB23jXSBDsQ=;
        b=c5qL/XHDthDsJjKSgNdLB0VX9sPRBZnBv3Prt869osLgxLi1zxs6mMKg6zmQPmvm+v
         JyqswwPOaaFiqTRxF+5DkzLwVHoDzMXaqb9kLVJWXTuHR6/JdgmZKiG+LxKE+xDsulqR
         cQVdxXEAOes+XdkdBOjRe/arQcm8Ovnetdg3xJfgrPxxvdedfg46KzRhEbxhj0HIo6Nx
         d5/UVFeGstYCnp0k+7ioA8v3mOmueBG4zerLHjB1Mn69WrvltInI/23kmggpb1XlQaiL
         VTEHDiQNbAW44IOiOgxaB69izCqg9YKf/zoOrxVnwB2ifpB85m07jpdSifs5uPpX5rSl
         N+gA==
X-Forwarded-Encrypted: i=1; AJvYcCVC8iK/GrIJyT8g0yG0nAROyWoWOFINlsS6dkixc9txndABdYLPsizVEuh8HqFFMoDGPPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1xG47bwNUUmGSkGkKJa08gUp81lhb/ZqSKQ94vP+fgNGgzYMo
	aEw8zM+tM+bVNFv7uvw0FTtOtFqq4GICz5rIJnbyh1M9ocjdS5kNRI1K9oBGXwWmTRvqKb8N7dX
	+CcxzB7WdO8j4vPquRD25RnmvJvou1Ods7zqKBdl6
X-Gm-Gg: AY/fxX7WZ+GDOYPsJkGgF1BRlJHeYUp1tEAyb09QbdsSkx3Ajzks2rDTbiM2G37iECY
	nhjSfyAgepfsaqfmNzSfCQZ6cKbC+nrP4WLNLBKAyXJcpqzjqHSCqc22sGP5v8kRJDTbfhL9ecv
	6JPTWzdhkmiNK9O2xQE9IpjwUegJJ47XzLVwekZflxV4eTkdN8KC5+0/YnPXFG4NbDQdOijf6Dl
	IXtE+Ja6+IJSNw9N9jDx6em4LMnvBdhWKB5MnAbKS2aR8kisyvaXD9LU3G4dEeGq8mZC2afA9uk
	7kn8XAFUVHL9wnobOne3+3WPhxUTZ2kXYbWC44b5
X-Google-Smtp-Source: AGHT+IHVh8eLKpaijBmtej8JNP9l5BuEt+L1FiZ6GAX1kllnmfaRBgU0fQqDiQkN+GRgB3dNSpIG4t8Wpfj2yQhjknU=
X-Received: by 2002:a05:651c:3052:b0:37a:3963:cec5 with SMTP id
 38308e7fff4ca-37fd1fc33c7mr5353161fa.43.1765547861262; Fri, 12 Dec 2025
 05:57:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211124614.161900-1-aleksandr.mikhalitsyn@canonical.com> <20251211124614.161900-7-aleksandr.mikhalitsyn@canonical.com>
In-Reply-To: <20251211124614.161900-7-aleksandr.mikhalitsyn@canonical.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 12 Dec 2025 21:57:29 +0800
X-Gm-Features: AQt7F2rm4SChMU9h5dmQ-ozCj4cn936wN8GGgpMwfta-TqLqKnWcMkf_uYnMIVs
Message-ID: <CALCETrW-u5NzBy4Esdg5J_eDQ-5YLNu86Kt0kdSZ00cPD=FefA@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] seccomp: allow nested listeners
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: kees@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Will Drewry <wad@chromium.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <shuah@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Tycho Andersen <tycho@tycho.pizza>, 
	Andrei Vagin <avagin@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	=?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 8:47=E2=80=AFPM Alexander Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:
>
> Now everything is ready to get rid of "only one listener per tree"
> limitation.
>
> Let's introduce a new uAPI flag
> SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS, so userspace may explicitly
> allow nested listeners when installing a listener.
>
> Note, that to install n-th listener, this flag must be set on all
> the listeners up the tree.


> diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentati=
on/userspace-api/seccomp_filter.rst
> index cff0fa7f3175..b9633ab1ed47 100644
> --- a/Documentation/userspace-api/seccomp_filter.rst
> +++ b/Documentation/userspace-api/seccomp_filter.rst
> @@ -210,6 +210,12 @@ notifications from both tasks will appear on the sam=
e filter fd. Reads and
>  writes to/from a filter fd are also synchronized, so a filter fd can saf=
ely
>  have many readers.
>
> +By default, only one listener within seccomp filters tree is allowed. On=
 attempt
> +to add a new listener when one already exists in the filter tree, the
> +``seccomp()`` call will fail with ``-EBUSY``. To allow multiple listener=
s, the
> +``SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS`` flag can be passed in add=
ition to
> +the ``SECCOMP_FILTER_FLAG_NEW_LISTENER`` flag.
> +

I read this, and I contemplated: does this mean that this permits
additional filters (added later, nested inside) to have listeners or
does it permit applying a listener when there already is one?  I
thought it was surely it's the former, but I had to read the code to
confirm that.

Maybe clarify the text?

(Yes, I realize it's also in the commit message, but that's not a
great place to hide this info.)


>  The interface for a seccomp notification fd consists of two structures:
>
>  .. code-block:: c
> diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> index 9b959972bf4a..9b060946019d 100644
> --- a/include/linux/seccomp.h
> +++ b/include/linux/seccomp.h
> @@ -10,7 +10,8 @@
>                                          SECCOMP_FILTER_FLAG_SPEC_ALLOW |=
 \
>                                          SECCOMP_FILTER_FLAG_NEW_LISTENER=
 | \
>                                          SECCOMP_FILTER_FLAG_TSYNC_ESRCH =
| \
> -                                        SECCOMP_FILTER_FLAG_WAIT_KILLABL=
E_RECV)
> +                                        SECCOMP_FILTER_FLAG_WAIT_KILLABL=
E_RECV | \
> +                                        SECCOMP_FILTER_FLAG_ALLOW_NESTED=
_LISTENERS)
>
>  /* sizeof() the first published struct seccomp_notif_addfd */
>  #define SECCOMP_NOTIFY_ADDFD_SIZE_VER0 24
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index dbfc9b37fcae..de78d8e7a70b 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -18,13 +18,14 @@
>  #define SECCOMP_GET_NOTIF_SIZES                3
>
>  /* Valid flags for SECCOMP_SET_MODE_FILTER */
> -#define SECCOMP_FILTER_FLAG_TSYNC              (1UL << 0)
> -#define SECCOMP_FILTER_FLAG_LOG                        (1UL << 1)
> -#define SECCOMP_FILTER_FLAG_SPEC_ALLOW         (1UL << 2)
> -#define SECCOMP_FILTER_FLAG_NEW_LISTENER       (1UL << 3)
> -#define SECCOMP_FILTER_FLAG_TSYNC_ESRCH                (1UL << 4)
> +#define SECCOMP_FILTER_FLAG_TSYNC                      (1UL << 0)
> +#define SECCOMP_FILTER_FLAG_LOG                                (1UL << 1=
)
> +#define SECCOMP_FILTER_FLAG_SPEC_ALLOW                 (1UL << 2)
> +#define SECCOMP_FILTER_FLAG_NEW_LISTENER               (1UL << 3)
> +#define SECCOMP_FILTER_FLAG_TSYNC_ESRCH                        (1UL << 4=
)
>  /* Received notifications wait in killable state (only respond to fatal =
signals) */
> -#define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV (1UL << 5)
> +#define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV         (1UL << 5)
> +#define SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS     (1UL << 6)
>
>  /*
>   * All BPF programs must return a 32-bit value.
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 51d0d8adaffb..7667f443ff6c 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -206,6 +206,7 @@ static inline void seccomp_cache_prepare(struct secco=
mp_filter *sfilter)
>   * @wait_killable_recv: Put notifying process in killable state once the
>   *                     notification is received by the userspace listene=
r.
>   * @first_listener: true if this is the first seccomp listener installed=
 in the tree.
> + * @allow_nested_listeners: Allow nested seccomp listeners.
>   * @prev: points to a previously installed, or inherited, filter
>   * @prog: the BPF program to evaluate
>   * @notif: the struct that holds all notification related information
> @@ -228,6 +229,7 @@ struct seccomp_filter {
>         bool log : 1;
>         bool wait_killable_recv : 1;
>         bool first_listener : 1;
> +       bool allow_nested_listeners : 1;
>         struct action_cache cache;
>         struct seccomp_filter *prev;
>         struct bpf_prog *prog;
> @@ -956,6 +958,10 @@ static long seccomp_attach_filter(unsigned int flags=
,
>         if (flags & SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV)
>                 filter->wait_killable_recv =3D true;
>
> +       /* Set nested listeners allow flag, if present. */
> +       if (flags & SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS)
> +               filter->allow_nested_listeners =3D true;
> +
>         /*
>          * If there is an existing filter, make it the prev and don't dro=
p its
>          * task reference.
> @@ -1997,7 +2003,8 @@ static struct file *init_listener(struct seccomp_fi=
lter *filter)
>  }
>
>  /*
> - * Does @new_child have a listener while an ancestor also has a listener=
?
> + * Does @new_child have a listener while an ancestor also has a listener
> + * and hasn't allowed nesting?
>   * If so, we'll want to reject this filter.
>   * This only has to be tested for the current process, even in the TSYNC=
 case,
>   * because TSYNC installs @child with the same parent on all threads.
> @@ -2015,7 +2022,12 @@ static bool check_duplicate_listener(struct seccom=
p_filter *new_child)
>                 return false;
>         for (cur =3D current->seccomp.filter; cur; cur =3D cur->prev) {
>                 if (!IS_ERR_OR_NULL(cur->notif))
> -                       return true;
> +                       /*
> +                        * We don't need to go up further, because if the=
re is a
> +                        * listener with nesting allowed, then all the li=
steners
> +                        * up the tree have allowed nesting as well.
> +                        */
> +                       return !cur->allow_nested_listeners;
>         }
>
>         /* Mark first listener in the tree. */
> @@ -2062,10 +2074,12 @@ static long seccomp_set_mode_filter(unsigned int =
flags,
>                 return -EINVAL;
>
>         /*
> -        * The SECCOMP_FILTER_FLAG_WAIT_KILLABLE_SENT flag doesn't make s=
ense
> +        * The SECCOMP_FILTER_FLAG_WAIT_KILLABLE_SENT and
> +        * SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS flags don't make se=
nse
>          * without the SECCOMP_FILTER_FLAG_NEW_LISTENER flag.
>          */
> -       if ((flags & SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV) &&
> +       if (((flags & SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV) ||
> +            (flags & SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS)) &&
>             ((flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) =3D=3D 0))
>                 return -EINVAL;
>
> diff --git a/tools/include/uapi/linux/seccomp.h b/tools/include/uapi/linu=
x/seccomp.h
> index dbfc9b37fcae..de78d8e7a70b 100644
> --- a/tools/include/uapi/linux/seccomp.h
> +++ b/tools/include/uapi/linux/seccomp.h
> @@ -18,13 +18,14 @@
>  #define SECCOMP_GET_NOTIF_SIZES                3
>
>  /* Valid flags for SECCOMP_SET_MODE_FILTER */
> -#define SECCOMP_FILTER_FLAG_TSYNC              (1UL << 0)
> -#define SECCOMP_FILTER_FLAG_LOG                        (1UL << 1)
> -#define SECCOMP_FILTER_FLAG_SPEC_ALLOW         (1UL << 2)
> -#define SECCOMP_FILTER_FLAG_NEW_LISTENER       (1UL << 3)
> -#define SECCOMP_FILTER_FLAG_TSYNC_ESRCH                (1UL << 4)
> +#define SECCOMP_FILTER_FLAG_TSYNC                      (1UL << 0)
> +#define SECCOMP_FILTER_FLAG_LOG                                (1UL << 1=
)
> +#define SECCOMP_FILTER_FLAG_SPEC_ALLOW                 (1UL << 2)
> +#define SECCOMP_FILTER_FLAG_NEW_LISTENER               (1UL << 3)
> +#define SECCOMP_FILTER_FLAG_TSYNC_ESRCH                        (1UL << 4=
)
>  /* Received notifications wait in killable state (only respond to fatal =
signals) */
> -#define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV (1UL << 5)
> +#define SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV         (1UL << 5)
> +#define SECCOMP_FILTER_FLAG_ALLOW_NESTED_LISTENERS     (1UL << 6)
>
>  /*
>   * All BPF programs must return a 32-bit value.
> --
> 2.43.0
>


--
Andy Lutomirski
AMA Capital Management, LLC

