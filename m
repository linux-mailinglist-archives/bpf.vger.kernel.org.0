Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7711F62CE77
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 00:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbiKPXEa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 18:04:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238244AbiKPXE2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 18:04:28 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430EB32066
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 15:04:27 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 130so348549pgc.5
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 15:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XP941acguvK1ZAkrhvPDttgcSVa1z7xUK43PRl+uio=;
        b=56syu10yY4F1zazjA7qQqh2STRuHElk9eY+YEZ2JcKVraIu6zSy+d7hqJ6YBhnyKnk
         1+LuOwiNiju5AdvI9xdh5g/G80aKnuJ11AaNiNKaHFRuda9VJx8tJcobAEuesbGIYHgS
         tMzqZ7quPD44w/BpPwpIxIYOAHQ0Eu6vcZcGfDNkWyxWllI9JW5MvHxeDqabzek7mvJF
         lRPHcIEV4pjuGc5AmAsFH4Jf4S3BLYvw3FN1EFQw3CaTcsnQ/rxPpU5CayDHenZMNu9J
         ZglvH/USVkAoU8iRANLUdGJML73p0sP2EWzu5aiesLr10lbTtOu9kbvOSISR4gHJF93H
         u1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XP941acguvK1ZAkrhvPDttgcSVa1z7xUK43PRl+uio=;
        b=D61b02rwmpXSQWN6uMt5WDpgeLKNXlUD1a0M1ZYA/UtiAeYBiAJVVarztuWi/2OPGy
         wpmgV3uPHoFYOdb/teZlzXQVnT+wtuNF1nYFW5DNoX3BK5WniCR4RirB46c8lFL5f9O7
         tBTGu2vFhTzMS8ME0dDBU8cMzYFIMqc33b5/NzubLYO3cDrxB5pXfkXhWsgslNBMRP5A
         cCd01fOq4tqtqqC3RLdE2piydTy32lDcg1X7vfL8UBE8MdYurvauxpeUjwhFCGSXYvk7
         gSUm9SSwneWV6ehYV3HNoU0yVijvaa7b1uwGrFJQjDMrMiQt2tzaltztm1B5GI+P+5Wu
         Bbbg==
X-Gm-Message-State: ANoB5pmZ0V/gF1UzivkljwuakPWJemjtEodZf60FyamJrnd4PSBx/ge+
        IvBFlvEsBYEUTenqGAe1EVoEQY5KoVLezjkOqw/jokO/zBi5
X-Google-Smtp-Source: AA0mqf4KnTW/Rs1/rqT5ydHUWbdtFyquLEB9AfGl4n344VRBZodroHoiuUE+EPtZ149p+/6c710BcebRhYhln41jNs4=
X-Received: by 2002:aa7:9518:0:b0:56c:8c13:24fd with SMTP id
 b24-20020aa79518000000b0056c8c1324fdmr319516pfp.2.1668639866677; Wed, 16 Nov
 2022 15:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20221102000525.gonna.409-kees@kernel.org>
In-Reply-To: <20221102000525.gonna.409-kees@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 16 Nov 2022 18:04:15 -0500
Message-ID: <CAHC9VhRh2VSEHSOdiTg-1K0zbpa_oj9iKJHi6ZLYj3Ubt4tGRQ@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: Better reporting of actual LSMs at boot
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 1, 2022 at 8:05 PM Kees Cook <keescook@chromium.org> wrote:
>
> Enhance the details reported by "lsm.debug" in several ways:
>
> - report contents of "security=3D"
> - report contents of "CONFIG_LSM"
> - report contents of "lsm=3D"
> - report any early LSM details
> - whitespace-align the output of similar phases for easier visual parsing
> - change "disabled" to more accurate "skipped"
> - explain what "skipped" and "ignored" mean in a parenthetical
>
> Upgrade the "security=3D is ignored" warning from pr_info to pr_warn,
> and include full arguments list to make the cause even more clear.
>
> Replace static "Security Framework initializing" pr_info with specific
> list of the resulting order of enabled LSMs.
>
> For example, if the kernel is built with:
>
> CONFIG_SECURITY_SELINUX=3Dy
> CONFIG_SECURITY_APPARMOR=3Dy
> CONFIG_SECURITY_LOADPIN=3Dy
> CONFIG_SECURITY_YAMA=3Dy
> CONFIG_SECURITY_SAFESETID=3Dy
> CONFIG_SECURITY_LOCKDOWN_LSM=3Dy
> CONFIG_SECURITY_LANDLOCK=3Dy
> CONFIG_INTEGRITY=3Dy
> CONFIG_BPF_LSM=3Dy
> CONFIG_DEFAULT_SECURITY_APPARMOR=3Dy
> CONFIG_LSM=3D"landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,=
smack,tomoyo,apparmor,bpf"
>
> Booting without options will show:
>
> LSM: initializing lsm=3Dlockdown,capability,landlock,yama,loadpin,safeset=
id,integrity,selinux,bpf
> landlock: Up and running.
> Yama: becoming mindful.
> LoadPin: ready to pin (currently not enforcing)
> SELinux:  Initializing.
> LSM support for eBPF active
>
> Boot with "lsm.debug" will show:
>
> LSM: legacy security=3D *unspecified*
> LSM: CONFIG_LSM=3Dlandlock,lockdown,yama,loadpin,safesetid,integrity,seli=
nux,smack,tomoyo,apparmor,bpf
> LSM: boot arg lsm=3D *unspecified*
> LSM:   early started: lockdown (enabled)
> LSM:   first ordered: capability (enabled)
> LSM: builtin ordered: landlock (enabled)
> LSM: builtin ignored: lockdown (not built into kernel)
> LSM: builtin ordered: yama (enabled)
> LSM: builtin ordered: loadpin (enabled)
> LSM: builtin ordered: safesetid (enabled)
> LSM: builtin ordered: integrity (enabled)
> LSM: builtin ordered: selinux (enabled)
> LSM: builtin ignored: smack (not built into kernel)
> LSM: builtin ignored: tomoyo (not built into kernel)
> LSM: builtin ordered: apparmor (enabled)
> LSM: builtin ordered: bpf (enabled)
> LSM: exclusive chosen:   selinux
> LSM: exclusive disabled: apparmor
> LSM: initializing lsm=3Dlockdown,capability,landlock,yama,loadpin,safeset=
id,integrity,selinux,bpf
> LSM: cred blob size       =3D 32
> LSM: file blob size       =3D 16
> LSM: inode blob size      =3D 72
> LSM: ipc blob size        =3D 8
> LSM: msg_msg blob size    =3D 4
> LSM: superblock blob size =3D 80
> LSM: task blob size       =3D 8
> LSM: initializing capability
> LSM: initializing landlock
> landlock: Up and running.
> LSM: initializing yama
> Yama: becoming mindful.
> LSM: initializing loadpin
> LoadPin: ready to pin (currently not enforcing)
> LSM: initializing safesetid
> LSM: initializing integrity
> LSM: initializing selinux
> SELinux:  Initializing.
> LSM: initializing bpf
> LSM support for eBPF active
>
> And some examples of how the lsm.debug ordering report changes...
>
> With "lsm.debug security=3Dselinux":
>
> LSM: legacy security=3Dselinux
> LSM: CONFIG_LSM=3Dlandlock,lockdown,yama,loadpin,safesetid,integrity,seli=
nux,smack,tomoyo,apparmor,bpf
> LSM: boot arg lsm=3D *unspecified*
> LSM:   early started: lockdown (enabled)
> LSM:   first ordered: capability (enabled)
> LSM: security=3Dselinux disabled: apparmor (only one legacy major LSM)
> LSM: builtin ordered: landlock (enabled)
> LSM: builtin ignored: lockdown (not built into kernel)
> LSM: builtin ordered: yama (enabled)
> LSM: builtin ordered: loadpin (enabled)
> LSM: builtin ordered: safesetid (enabled)
> LSM: builtin ordered: integrity (enabled)
> LSM: builtin ordered: selinux (enabled)
> LSM: builtin ignored: smack (not built into kernel)
> LSM: builtin ignored: tomoyo (not built into kernel)
> LSM: builtin ordered: apparmor (disabled)
> LSM: builtin ordered: bpf (enabled)
> LSM: exclusive chosen:   selinux
> LSM: initializing lsm=3Dlockdown,capability,landlock,yama,loadpin,safeset=
id,integrity,selinux,bpf
>
> With "lsm.debug lsm=3Dintegrity,selinux,loadpin,crabability,bpf,loadpin,l=
oadpin":
>
> LSM: legacy security=3D *unspecified*
> LSM: CONFIG_LSM=3Dlandlock,lockdown,yama,loadpin,safesetid,integrity,seli=
nux,smack,tomoyo,apparmor,bpf
> LSM: boot arg lsm=3Dintegrity,selinux,loadpin,capability,bpf,loadpin,load=
pin
> LSM:   early started: lockdown (enabled)
> LSM:   first ordered: capability (enabled)
> LSM: cmdline ordered: integrity (enabled)
> LSM: cmdline ordered: selinux (enabled)
> LSM: cmdline ordered: loadpin (enabled)
> LSM: cmdline ignored: crabability (not built into kernel)
> LSM: cmdline ordered: bpf (enabled)
> LSM: cmdline skipped: apparmor (not in requested order)
> LSM: cmdline skipped: yama (not in requested order)
> LSM: cmdline skipped: safesetid (not in requested order)
> LSM: cmdline skipped: landlock (not in requested order)
> LSM: exclusive chosen:   selinux
> LSM: initializing lsm=3Dlockdown,capability,integrity,selinux,loadpin,bpf
>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2: en/dis-enabled expanded, example output in commit log, use pr_cont.
> v1: https://lore.kernel.org/lkml/20221018064825.never.323-kees@kernel.org=
/
> ---
>  security/security.c | 45 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 36 insertions(+), 9 deletions(-)

I tend to agree with Micka=C3=ABl regarding the aligned output, but that's
not worth worrying too much about for debug stuff.  Merged into
lsm/next, thanks Kees.

--=20
paul-moore.com
