Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B42817A6BC
	for <lists+bpf@lfdr.de>; Thu,  5 Mar 2020 14:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgCENup (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 08:50:45 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38338 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgCENup (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Mar 2020 08:50:45 -0500
Received: by mail-oi1-f196.google.com with SMTP id x75so5990445oix.5;
        Thu, 05 Mar 2020 05:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fcCTfa/+b2H8bD6/l2jkw8E4TRC6mBDpyhRVH0rkeuw=;
        b=bob5i7Hx/1c84xrjeDHggoA7v1P27/LaFo+Tv1+2TxOFFyU6cuvCSz7SHlOOspW8Fs
         AgDpkhqBum4Tb5nRKQP5LEZNWteQW+XO5aV2rLWhs7C3kVnZWlXBBFpTW815/ib5loHl
         Lte9VAzb954Y+9kOYs3Zoj3CIawohp39tvMtbhkPH073pg8hSpC5HeRbJ9gsHlQIM2mA
         MMzNaJVtN1XHin5uT4UKfWT7HOlnGQCsSptHEWHriu7ByFd8D4K/wv66VvC+76qbNJGW
         i1XWeWsA6B67rMal1OugqQJWDfFLuDAGtWFC6tOloj7dkiBD7nAjtqjXz1c6lGuGJJZR
         ouFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fcCTfa/+b2H8bD6/l2jkw8E4TRC6mBDpyhRVH0rkeuw=;
        b=jHULGypSb6U4xMr3J0gXv7rjwXJVycoP79vibY8OzyWbSgr5v00N71xnBppfQqytcE
         cM+fWNlZGXEPPBdYkHl+U8nEN92Od9Ms5BrwlDnr1J1pSNTDr00W4u7znIOq3VewQ+mc
         Shb4WoDkQIkal9YQnm3LnRPNobbFFS7s9fi2wTKA5fSV49xZ8GdWarTZBwYal2qdkpGS
         huF3I90mY5+AV/MtVXioxY+kdC82mRnRr624VM3vZTHJZz2Bh7430DYAIIfb7kPFdZKJ
         XiFJGvnWw4z7SORdHGRNC6lftc0wydX2USFHYWMDmo051H01MskkTpW5JHuhP1sS0NPa
         m+7w==
X-Gm-Message-State: ANhLgQ3ZaozaziZsff7vSgM1CUHcuCKyCqn0tRB97wEBAbjH6zq3mzSy
        hyE2cR+uF3O2dSAb/tVgtbcuTvfWGMVReTiRqGE=
X-Google-Smtp-Source: ADFU+vtIByz2R0kLCeIr1TlairntfhCiMv9MbVfDdAkVKlBSQ+hpH0fDPPDbLe5Vog30q1evW1THoDq5tC/2YlQmzv4=
X-Received: by 2002:aca:3544:: with SMTP id c65mr5488952oia.160.1583416244454;
 Thu, 05 Mar 2020 05:50:44 -0800 (PST)
MIME-Version: 1.0
References: <20200304191853.1529-1-kpsingh@chromium.org> <20200304191853.1529-4-kpsingh@chromium.org>
In-Reply-To: <20200304191853.1529-4-kpsingh@chromium.org>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 5 Mar 2020 08:51:58 -0500
Message-ID: <CAEjxPJ4+aW5JVC9QjJywjNUS=+cVJeaWwRHLwOssLsZyhX3siw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/7] bpf: Introduce BPF_MODIFY_RETURN
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>, casey@schaufler-ca.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 4, 2020 at 2:20 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> When multiple programs are attached, each program receives the return
> value from the previous program on the stack and the last program
> provides the return value to the attached function.
>
> The fmod_ret bpf programs are run after the fentry programs and before
> the fexit programs. The original function is only called if all the
> fmod_ret programs return 0 to avoid any unintended side-effects. The
> success value, i.e. 0 is not currently configurable but can be made so
> where user-space can specify it at load time.
>
> For example:
>
> int func_to_be_attached(int a, int b)
> {  <--- do_fentry
>
> do_fmod_ret:
>    <update ret by calling fmod_ret>
>    if (ret != 0)
>         goto do_fexit;
>
> original_function:
>
>     <side_effects_happen_here>
>
> }  <--- do_fexit
>
> The fmod_ret program attached to this function can be defined as:
>
> SEC("fmod_ret/func_to_be_attached")
> int BPF_PROG(func_name, int a, int b, int ret)
> {
>         // This will skip the original function logic.
>         return 1;
> }
>
> The first fmod_ret program is passed 0 in its return argument.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

IIUC you've switched from a model where the BPF program would be
invoked after the original function logic
and the BPF program is skipped if the original function logic returns
non-zero to a model where the BPF program is invoked first and
the original function logic is skipped if the BPF program returns
non-zero.  I'm not keen on that for userspace-loaded code attached
to LSM hooks; it means that userspace BPF programs can run even if
SELinux would have denied access and SELinux hooks get
skipped entirely if the BPF program returns an error.  I think Casey
may have wrongly pointed you in this direction on the grounds
it can already happen with the base DAC checking logic.  But that's
kernel DAC checking logic, not userspace-loaded code.
And the existing checking on attachment is not sufficient for SELinux
since CAP_MAC_ADMIN is not all powerful to SELinux.
Be careful about designing your mechanisms around Smack because Smack
is not the only LSM.
