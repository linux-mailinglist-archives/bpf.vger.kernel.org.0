Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B742FF58D
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 21:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbhAUUMG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 15:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbhAUUIq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 15:08:46 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32DDC061756;
        Thu, 21 Jan 2021 12:08:05 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id w24so3262255ybi.7;
        Thu, 21 Jan 2021 12:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M9gSCtwCI+xE4f8ZYH8DQVpM185t7FjYnWXxrvouoqk=;
        b=UChm+nd4bNLapGQcwGxjAWtIPmBvAVynD2hsIwZkkvKeKK5IOoV1ZqEyywYHLEFg3+
         fGc96x/pq8+uy3bsHsrIdES4BKk1JWW8bLqVSkRr1KD6hjf22CH44CZ7yCYuQwmxG43r
         dr8akq6bZsxuG1pIDKyDOx/+eWtfdIAv5nAHAwqEBwkj06rcgsOHBfrHlSh5hgOsHYQ3
         VrwTNxZnR1cUsvM3QvsRFVd9W2wO/byk/aqGL6uha9R426oqE2B/oxZ51R3tsKMQcWw/
         QeR/x73OEXfCWqMhmxcXguliu8751gTVUTDmEbFaa1CPtfCxNeFoUelWfA1NCQLVocWQ
         h8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M9gSCtwCI+xE4f8ZYH8DQVpM185t7FjYnWXxrvouoqk=;
        b=jELZCcN7PJFzYUVMPNRW6JqNauKGVHzGteYQda1jA6QfmTjNzh5MQ5rsqfl/X7Nzlb
         jb6jrF4msydD+IyZHSlslWq4HcWT+e7tisKjGu1rM3ckqiylzhuwsRyzqnBcH4LRbQq8
         UWNJGSK9sHgkKMEpQPaS/GH4CSvcyXq8eeVZyp5drR6sfl9PQarBLsOnBXYhuHmoz4co
         oVrNr2e2J4mcvrWGuFn43pjNG0/Ggwx0yUx21rA5NaXjq0TBpN+FYSjekvEPdca6mVg8
         o33CYNOlR/opngOWglqQovPoiuZCusSdjotzNL9cKKugV4VHglq0/MoMUgy4nRkTi3ri
         elng==
X-Gm-Message-State: AOAM532fnh7RRXC9uVerX21jwWyVSeve3ZaMmyeV09axNsQ+CkOs6GqA
        Y6bv3Z62TgkLYsjceklxtHduQnhw2dY6KtxNBgQ=
X-Google-Smtp-Source: ABdhPJyKpYapMO8/MUzqdd/7AexI/ESRgtodN8GZScSiCDvImTNnHOQtJH6AnnDDSgq6k5XGZHRNPCxTKMTm3dkadkQ=
X-Received: by 2002:a25:48c7:: with SMTP id v190mr1499762yba.260.1611259685093;
 Thu, 21 Jan 2021 12:08:05 -0800 (PST)
MIME-Version: 1.0
References: <20210118160139.1971039-1-gprocida@google.com> <20210118160139.1971039-4-gprocida@google.com>
 <CAEf4BzazvC9H=K_A9KamGTB3iKtjuNxd4hEvwFOnkPdnszo6Bw@mail.gmail.com> <CAGvU0HmE+gs8eNQcXmFrEERHaiGEnMgqxBho4Ny3DLCe6WR55Q@mail.gmail.com>
In-Reply-To: <CAGvU0HmE+gs8eNQcXmFrEERHaiGEnMgqxBho4Ny3DLCe6WR55Q@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 21 Jan 2021 12:07:54 -0800
Message-ID: <CAEf4BzZQvLofuVHPqu1ybsTVrM9pFRCRSR5UEFdNJq3Ha8=Luw@mail.gmail.com>
Subject: Re: [PATCH 3/3] btf_encoder: Set .BTF section alignment to 16
To:     Giuliano Procida <gprocida@google.com>
Cc:     dwarves@vger.kernel.org, kernel-team@android.com,
        =?UTF-8?Q?Matthias_M=C3=A4nnich?= <maennich@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 21, 2021 at 3:07 AM Giuliano Procida <gprocida@google.com> wrot=
e:
>
> Hi.
>
> On Thu, 21 Jan 2021 at 07:16, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
>>
>> On Mon, Jan 18, 2021 at 8:01 AM Giuliano Procida <gprocida@google.com> w=
rote:
>> >
>> > This is to avoid misaligned access when memory-mapping ELF sections.
>> >
>> > Signed-off-by: Giuliano Procida <gprocida@google.com>
>> > ---
>> >  libbtf.c | 8 ++++++++
>> >  1 file changed, 8 insertions(+)
>> >
>> > diff --git a/libbtf.c b/libbtf.c
>> > index 7552d8e..2f12d53 100644
>> > --- a/libbtf.c
>> > +++ b/libbtf.c
>> > @@ -797,6 +797,14 @@ static int btf_elf__write(const char *filename, s=
truct btf *btf)
>> >                         goto unlink;
>> >                 }
>> >
>> > +               snprintf(cmd, sizeof(cmd), "%s --set-section-alignment=
 .BTF=3D16 %s",
>> > +                        llvm_objcopy, filename);
>>
>> does it align inside the ELF file to 16 bytes, or does it request the
>> linker to align it at 16 byte alignment in memory? Given .BTF section
>> is not loadable, trying to understand the implications.
>>
>
> We have a tool that loads BTF from ELF files. It uses mmap and "parses" t=
he BTF as structs in memory. The ELF file is mapped with page alignment but=
 the BTF section within it has no alignment at all. Using MSAN (IIRC) we ge=
t warnings about misaligned accesses. Everything within BTF itself is natur=
ally aligned, so it makes sense to align the section within ELF as well. Th=
ere are probably some architectures where this makes the difference between=
 working and SIGBUS.
>

Right, ok, thanks for explaining!

> I did try to get objcopy to set alignment at the point the section is add=
ed. However, this didn't work.
>
>>
>>
>> > +               if (system(cmd)) {
>>
>> Also curious, if objcopy emits error (saying that
>> --set-section-alignment argument is not recognized), will that error
>> be shown in stdout? or system() consumes it without redirecting it to
>> stdout?
>>
>
> I believe it goes to stderr. I would need to check. system() will not con=
sume this. I'm not keen to write stderr (or stdout) post-processing code in=
 plain C.
>

You can use popen() to capture/hide output, this is a better
alternative to system() in this case. We don't want "expected
warnings" in kernel build process.

>>
>> > +                       /* non-fatal, this is a nice-to-have and it's =
only supported from LLVM 10 */
>> > +                       fprintf(stderr, "%s: warning: failed to align =
.BTF section in '%s': %d!\n",
>> > +                               __func__, filename, errno);
>>
>> Probably better to emit this warning only in verbose mode, otherwise
>> lots of people will start complaining that they get some new warnings
>> from pahole.
>>
>
> It may be better to just use POSIX and ELF APIs directly instead of objco=
py. This way the section can be added with the right alignment directly. pa=
hole is already linked against libelf and if we could get rid of the extern=
al dependency on objcopy it would be a win in more than one way.

This would be great, yes. At some point I remember giving it a try,
but for some reason I couldn't make libelf flush data and update
section headers properly. Maybe you'll have better luck. Though I
think I was trying to mark section loadable, and eventually I probably
managed to do that, but still abandoned it (it's not enough to mark
section loadable, you have to assign it to ELF segment as well, which
libelf doesn't allow to do and you need linker support). Anyways, give
it a try, it should work.

>
>>
>>
>> > +               }
>> > +
>> >                 err =3D 0;
>> >         unlink:
>> >                 unlink(tmp_fn);
>> > --
>> > 2.30.0.284.gd98b1dd5eaa7-goog
>> >
>
>
> I'll see if I can spend a little time on this idea instead.
>
> Regards,
> Giuliano.
