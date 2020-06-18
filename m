Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED421FEF8B
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 12:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgFRKUD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 06:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgFRKUC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Jun 2020 06:20:02 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F93C06174E
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 03:20:01 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w16so5821545ejj.5
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 03:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=up9D0o+AX2qYGWNzMhoiy42Ev9Wr8Rz85ohKGlSqQ0U=;
        b=Jesg79CtOMTpbspZ+IoydlUzspnzkiV3F0D3dRrZEdmk1/mQaqfA45SE864sqC4Ffd
         Fy9Ywi6WPJ8CoFbruS8xb16io79uO3CBYdwABKB/eV525K7F/t43AJjzVFi4zt+GKSSN
         zZINApgo6tNcc8Uj7V1SwkWsfVepwNceckkbKroLG0PQzDorLxLIhcnOLA9VEKUJ7Ow9
         EVV/7EYnh6q0bjtijaTlIXyViV0wqaEQ5ptGYtZBDGCLpqubQzsZBlmbaJrePAl9m+bi
         iTfwG6HYD6e47IuhJ+1opShz+fUcdNbOBY1ZkHitEA696JkvIHrIQ0LjPcqIB3NGl6pY
         AekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=up9D0o+AX2qYGWNzMhoiy42Ev9Wr8Rz85ohKGlSqQ0U=;
        b=Ni31GWAz0EUX1freMh+1iQ2S2DdP1VuuwmemjgY7bEqjDt7gVC8T95gr6+BcxmJEU3
         UdLj3ubvsQiY5AqlFfgqVyqmN3Fkoe8Efu90yRrIL0Zm2bsNGfTX9l1eOGPj8EhprrrQ
         UYm+MsVldno0OkPJoswNkc3fspLwlUOv/tG7EoG1b/fFUF1GNDTIoCG5oQnxoqTpAPUF
         o0SJ/aJxsxefBD/cJ/D1sps4/Lty+XlEM9GiQ9kpGY77Vsyyn1fQNHgZUWhkXP7RHFau
         sc96d3OkJnU4BfW9GloBUM3cwxkpSMNcxbZxeuQA9Ip5r47Hm1bNcAXPkuYKm76JbZFe
         SP0g==
X-Gm-Message-State: AOAM531O3RYV6GoYSjQ8QWM9YQYqxTzJMqy0+bMEb8C2VaNpPopGwuCK
        0toI7qPibxTHeLpA3213tpvjD4AfJTAcsF30U4fLPDl1
X-Google-Smtp-Source: ABdhPJzsHJgfjGuS2xW+lHwiWnkQMpv0aHnYCdM9AA+r/pUVYDweI7W2lQ6vhylm0kT+c+b89o/lWfQuja5iYZ7fHFQ=
X-Received: by 2002:a17:906:7751:: with SMTP id o17mr3406640ejn.111.1592475600448;
 Thu, 18 Jun 2020 03:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHo-OoxJ6XBrBDXUxhCr0J58eOGq3FZu5+Rg6GLeeCjThrA8rg@mail.gmail.com>
 <CAADnVQKXbd986SrW2u4nxY-0nNuC7VoVM29=3LeD9potOJTdZQ@mail.gmail.com>
In-Reply-To: <CAADnVQKXbd986SrW2u4nxY-0nNuC7VoVM29=3LeD9potOJTdZQ@mail.gmail.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date:   Thu, 18 Jun 2020 03:19:49 -0700
Message-ID: <CAHo-Ooz4smKgTDTit4NAnaasUDLJLkX7iRcYouv4KY=AG5SUaA@mail.gmail.com>
Subject: Re: capable_bpf_net_admin()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     BPF Mailing List <bpf@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John has all the details.  I'm just guessing.

But having actually looked at the code, commit 2c78ee898d8f1 ie.

kernel/bpf/syscall.c: bpf_prog_load()
+       if (is_net_admin_prog_type(type) && !capable(CAP_NET_ADMIN))
+               return -EPERM;

looks fishy, since our bpfloader only has CHOWN SYS_ADMIN, and the
maps/programs it creates/loads are used by netd which only has
NET_ADMIN (but not SYS_ADMIN).  Furthermore I don't really want to
grant it NET_ADMIN.

I think this should again be either NET_ADMIN or SYS_ADMIN.

On Thu, Jun 18, 2020 at 12:01 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Jun 17, 2020 at 11:43 PM Maciej =C5=BBenczykowski
> <zenczykowski@gmail.com> wrote:
> >
> > is
> > (SYS_ADMIN || BPF) && NET_ADMIN
> >
> > should this not be
> > SYS_ADMIN || (BPF && NET_ADMIN)
> >
> > ?
>
> capable_bpf_net_admin doesn't exist.
>
> > Won't this cause a just SYS_ADMIN process to fail to load network bpf p=
rogs?
>
> if the process has cap_sys_admin it has all privs.
>
> > (I haven't debugged this at all, but John is reporting 5.8-rc1 fails
> > to load bpf progs from Android's bpfloader with EPERM error)
> >
> > Or are we okay with this user space visible behavioural change?
>
> What kind of change? Could you please be more specific?
