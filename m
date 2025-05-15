Return-Path: <bpf+bounces-58321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0648AB8A32
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 17:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404E21899E00
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 15:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F7F1FECD3;
	Thu, 15 May 2025 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5wYBohM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D601DE2D6
	for <bpf@vger.kernel.org>; Thu, 15 May 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321371; cv=none; b=d8lkA2AMQIO6L/Owwv5jvMbrjx5Hrc+zUCvFZcmZz5Vglx63nE3qcAhvosR0mPfzln2t6SlBJn6cJv5Iahk26rYKUhugHOSIxAPZoY5D4iVPjykBKeq54Ie7Swnh9l/78i463lABoIbHR0Q2f9sCIJMzNFE5yxez/r5eQncsUGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321371; c=relaxed/simple;
	bh=3KH9XWOnp3lfqwR44vhL7CvBTvN9J+uxq54a8FcGtA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdL6fw4MkGbyPZC/Z4Np/4LxZmocJ5TH83ywRHgDuCIImZU1AiQTl96/eJD+fUow2MPTksElUvgj9UEFj0QwdMydSk5NVSsT0OP9r8ZrV8bJyR8VPyvIpxAd0DuEgt0D7sDafPueLYmn9Fxh5QyIRPUXVZY5QiuBMg12vZsUNIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H5wYBohM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a0be321968so644053f8f.2
        for <bpf@vger.kernel.org>; Thu, 15 May 2025 08:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747321368; x=1747926168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2MhKFb5jQFsDsWD5YYixjajeyNhw+zGKEEVhOPPP6A=;
        b=H5wYBohM7Pd+LD/NDnk0y5t4Y5U+gqQJAjisFIhibU0xcHeqaFwUB7N+My2+fDS0VM
         Ngh26djzQKikv2Yhc9OqMpCEMoAWSx0qTCoAckEngHEaPuAoy+TKC3OPKcZYf58fTdjc
         /X2/gMMqhb+nvLVD+5OHF4qh4TAY4L9uebmPih8yil0UEYNnqruO5EPHkgE4kvsJ8nb6
         b2JBGuf+/6uwhdkJ/vnn6BQaDBrOV1zvJUtEOxQ/ihvoSR4X+TzB/OdjmADGL2Jqwuw6
         gJkOuaXwMVxdRfz7NAXfMdjEUHlhGTBbtYPrZpb/vWHWAH2SXjnx+NtOLalb/BzY20Yi
         GWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747321368; x=1747926168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2MhKFb5jQFsDsWD5YYixjajeyNhw+zGKEEVhOPPP6A=;
        b=BdDMItyxahXL3V7j+cYFqAobZttutOf3QXOfhD+GpnDo2aPCHCyeK5kBbqbMOetQcu
         jgnZA8gO0osWb9V40qFRYm9wR0pIHJvVx26rO12xTskK+Rk4uCdA1b1v/FPijRVE2jW2
         5VlMJlpWiP7JuzS9zhodYM6dAbYuBnwHs/fCeAGoJ3Pm0zUj9Gf6GBSArcyVRAXPSfqh
         txezgUA3JXp3jZ98LQluOhrttzPyITGNkO+p7Kb0rSpBrZenRySkvtvCgaQlVOB1Ydmw
         dGDkgICVXpFtNPsdTeMfRVxd0CdJpypsjPloAiWHx+3yHr++SrQo7J/tSWDypGZIabmi
         jwMQ==
X-Gm-Message-State: AOJu0YzRgC5zT1vcZv+u4jBqSAcHwSjdGq+k8xNn7JZDfmBMpejyKb83
	tFMipfF6C6Mhutp90PEJhOj5z5X3QCOFcFfaTXdWnue+dWQvF1KSPujh4eF2Gdt6sBSNKznhRVj
	bSAMhZM6TXJ8GFVsYfN9TZWXqU1vDPUI1hY9p
X-Gm-Gg: ASbGnctjDi/vJVTpPehdfNYLbOftgGPedYH9DTEhbxZmTYnE/qvR9Mfs1+mqFBZwzzJ
	Xd82lw9lmdzYkjulCkyeSraU2199ycbPA/SOCVGOebb3ETk1LpVQNCS5U/Wtkln15zMyx6HN1dy
	6wugfo/87dSHSsxIT+W7gieyIVJZR0X5waj+iI7SWd3HMy3l8aMaMQlla+odI=
X-Google-Smtp-Source: AGHT+IHRD8GQfikpVxcpjUleaC2yNBUvz3cvgGvkeefIg7PSvH0pe1uZ1y27vGfc1AY1X2Gj2sA9r/RLtAuI8Prebt0=
X-Received: by 2002:a05:6000:200f:b0:3a1:faa7:89e2 with SMTP id
 ffacd0b85a97d-3a35c84975amr67267f8f.58.1747321366754; Thu, 15 May 2025
 08:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aCXT7kLv-SHy44Vx@mail.gmail.com>
In-Reply-To: <aCXT7kLv-SHy44Vx@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 15 May 2025 08:02:34 -0700
X-Gm-Features: AX0GCFvt55hVvUKnefovE-305ewU8N7f0AEKTZaSMFODDCw6H6lL-OXzaWMhwkE
Message-ID: <CAADnVQJNYyiVQsqNZs-R6JOZ_TkEzTwSZyhAgwB1mDXQhksa6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: WARN_ONCE on verifier bugs
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 4:45=E2=80=AFAM Paul Chaignon <paul.chaignon@gmail.=
com> wrote:
>
> Throughout the verifier's logic, there are multiple checks for
> inconsistent states that should never happen and would indicate a
> verifier bug. These bugs are typically logged in the verifier logs and
> sometimes preceded by a WARN_ONCE.
>
> This patch reworks these checks to consistently emit a verifier log AND
> a warning when CONFIG_DEBUG_KERNEL is enabled. The consistent use of
> WARN_ONCE should help fuzzers (ex. syzkaller) expose any situation
> where they are actually able to reach one of those buggy verifier
> states.
>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---
> Changes in v3:
>   - Introduce and use verifier_bug_if, as suggested by Andrii.
> Changes in v2:
>   - Introduce a new BPF_WARN_ONCE macro, with WARN_ONCE conditioned on
>     CONFIG_DEBUG_KERNEL, as per reviews.
>   - Use the new helper function for verifier bugs missed in v1,
>     particularly around backtracking.
>
>  include/linux/bpf.h          |   6 ++
>  include/linux/bpf_verifier.h |  10 +++
>  kernel/bpf/btf.c             |   4 +-
>  kernel/bpf/verifier.c        | 121 ++++++++++++++++-------------------
>  4 files changed, 74 insertions(+), 67 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 83c56f40842b..5b25d278409b 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -346,6 +346,12 @@ static inline const char *btf_field_type_name(enum b=
tf_field_type type)
>         }
>  }
>
> +#if IS_ENABLED(CONFIG_DEBUG_KERNEL)
> +#define BPF_WARN_ONCE(cond, format...) WARN_ONCE(cond, format)
> +#else
> +#define BPF_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
> +#endif
> +
>  static inline u32 btf_field_type_size(enum btf_field_type type)
>  {
>         switch (type) {
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index cedd66867ecf..c3fd6905793a 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -839,6 +839,16 @@ __printf(3, 4) void verbose_linfo(struct bpf_verifie=
r_env *env,
>                                   u32 insn_off,
>                                   const char *prefix_fmt, ...);
>
> +#define verifier_bug_if(cond, env, fmt, args...)                        =
       \
> +       ({                                                               =
       \
> +               if (unlikely(cond)) {                                    =
       \
> +                       BPF_WARN_ONCE(1, "verifier bug: " fmt, ##args);  =
       \

> +                       bpf_log(&env->log, "verifier bug: " fmt, ##args);=
       \
> +               }                                                        =
       \
> +               (cond);                                                  =
       \
> +       })
> +#define verifier_bug(env, fmt, args...) verifier_bug_if(1, env, fmt, ##a=
rgs)
>

(cond) shouldn't be double evaluated.
Also let's stringify condition in verifier_bug_if().
The messages will be easier for humans to parse.
Especially when code evolves and line numbers don't correspond
to new code.

Then some text can be reduced, removed or reworded.
Like:
-                                       if
(WARN_ON_ONCE(env->cur_state->loop_entry)) {
-                                               verbose(env, "verifier
bug: env->cur_state->loop_entry !=3D NULL\n");
+                                       if
(verifier_bug_if(env->cur_state->loop_entry, env,
+
"cur_state->loop_entry not null\n"))

can be:
if (verifier_bug_if(env->cur_state->loop_entry, env, "broken loop detection=
"))

