Return-Path: <bpf+bounces-38328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD519636AE
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 02:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758441F24CA3
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 00:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84699256D;
	Thu, 29 Aug 2024 00:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSco76Ez"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B95DDA6;
	Thu, 29 Aug 2024 00:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724890122; cv=none; b=ennSxGGWBlTzjAydmZuiNHxKbcEO6I0GDi7wW9xGtxpikp14g2AwoNy0xBah0/6VpUdVbPOpFtyvCHoFafXfz1o5TjzF25dYDDogGOqScrSXAzldkX8FjLxFFAMF0S1E9qIlYd/8orkmYsBlx4TSqyG4wVDWC6xwGh1+sG2wWcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724890122; c=relaxed/simple;
	bh=4mrOInaGgcSsyPxSOv0jBWUB2KmSNACrUTxiR3RHI8c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gma87mcH4Sv3RO0o4ThicWXf7QYJnAs0pKyESwtztXiZwc+CgOLInOBzzS/0JrQykIj63XtRJHoIquBiUE9F66E841vHi4iMqF0isxQXbdrXoQJYh+Ny7G4wRQPpJSf4Nd0KRJ84h20hEpFs7OB/2zcUZEhaF6PCTNxPZsJw0HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSco76Ez; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso33440a12.0;
        Wed, 28 Aug 2024 17:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724890120; x=1725494920; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JwAJcNFbkfNLCvJ5Fy89lTRAKt+aTy//gJLU+v3KL2o=;
        b=XSco76EzxOpoj5WUGpaHpjzM7jf/JR8W3fucYk8dQscHkQAV7djvjR+rN2asIaa2DJ
         XK9pf0xnQdQaIEvtDTJREEfHxm64nKpcm04yBOzmpH7pui5JMDtod9i23Pwtoalm+KP/
         qkxIbnNrsgGwMNp9DaMtuaxSwBXgKHQTmg5E63uLql+HZDmY98J9ZqYVY6e1v6j3/zFS
         h+Zm4uFG2coWR4I4PzHiUv03T2Zm2IoGYdrnQMeXxuXpBMjERZELQmQA70gsm1WNhC19
         rcdnL+mbHa6VHRw01ifv081wCFz5EB694s0KmvUd1favY9oY5644PB0GOVpzlhId5qNz
         HlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724890120; x=1725494920;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JwAJcNFbkfNLCvJ5Fy89lTRAKt+aTy//gJLU+v3KL2o=;
        b=a+2sb7XSOjnl9tL0ggwbkT9uggB/9EcUY6+Erq7dcD2cTv4HNOEcvZh1CEMaSiI+h+
         iXkyhws5Ts2Skkp3EAZbEwP+euE2sdUdU+uQdZO64yFxeTxpShLW5Z0NnUomr6vd2vtx
         sJ264uro3XDlIE1/9qdLR9D8qLzUUlqYHwXFV3D36I9lUKlhJ1Fii2iIS9J9COvu8oyn
         RcCu8cwyn4wc0J+yMSz0WkTXbgxKKR3Yqgi919qnXjHd+Ea+KWeSdFQDR2mWHFZhdePX
         cxjWOm73MSyIvCRHWr0jPZHj8ddSkZ1YqQChCnrlYMSdNZ5ZETsl4S6nCQkcaEhDVx0o
         VCyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1Dla9MMPJQZqGorqqlkrffOt4wYgwNwejpKMxVBwGzUHJfysdy3dVX42uRqVC8okVKC66C1BH8Q==@vger.kernel.org, AJvYcCVp8GrZKjeMfnOTqLmTi2qF06hCoEd7b3sy/k43698I5ePa5dLwt3B6Sx/lVpFZP/5pzxDFg7TTogNkYSMy@vger.kernel.org, AJvYcCXQB2wzlQe1YyAZj5606oJMd0SOAds+xfs2bgUpdvM1bAt3NvXbuAARe4PqJIZh8ITF99Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YylTWUoL933GaveNFHgRIWryEfy+yMHK+fsDZiOE7ulhT73Ny7x
	/gaRWik5POstl/B+JSRHJ4ZMVC3VkBuj356LjW10j0VbxWgaURwC
X-Google-Smtp-Source: AGHT+IEz7DDxbFAT6mOeyMJDiHUnKBgQmO3DPznwmp0JxhvgeNKaIO5s8gmnsuyfvmHr4oyLGnrb9w==
X-Received: by 2002:a05:6a20:e196:b0:1c4:9100:6a1b with SMTP id adf61e73a8af0-1cce101dfdfmr998580637.30.1724890119797;
        Wed, 28 Aug 2024 17:08:39 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b3343sm482175ad.30.2024.08.28.17.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 17:08:39 -0700 (PDT)
Message-ID: <2b92648adb162a1c6202ba447277a37902d0b407.camel@gmail.com>
Subject: Re: [PATCH 1/1] pahole: Add option to obtain a vmlinux matching the
 running kernel
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko
 <andrii@kernel.org>,  Jiri Olsa <jolsa@kernel.org>,
 dwarves@vger.kernel.org, bpf@vger.kernel.org, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Date: Wed, 28 Aug 2024 17:08:34 -0700
In-Reply-To: <Zs977_n0rkleEl94@x1>
References: <Zs977_n0rkleEl94@x1>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-28 at 16:35 -0300, Arnaldo Carvalho de Melo wrote:

[...]

Tested-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -3707,6 +3716,21 @@ int main(int argc, char *argv[])
>  		goto out;
>  	}
> =20
> +	if (show_running_kernel_vmlinux) {
> +		const char *vmlinux =3D vmlinux_path__find_running_kernel();
> +
> +		if (vmlinux) {
> +			fprintf(stdout, "%s\n", vmlinux);
> +			rc =3D EXIT_SUCCESS;
> +		} else {
> +			fputs("pahole: couldn't find a vmlinux that matches the running kerne=
l\n"
> +			      "HINT: Maybe you're inside a container or missing a debuginfo p=
ackage?\n",
> +			      stderr);
> +		}

Nitpick: when run with valgrind this reports a leak for 'vmlinux':

    =3D=3D186=3D=3D Memcheck, a memory error detector
    =3D=3D186=3D=3D Copyright (C) 2002-2024, and GNU GPL'd, by Julian Sewar=
d et al.
    =3D=3D186=3D=3D Using Valgrind-3.23.0 and LibVEX; rerun with -h for cop=
yright info
    =3D=3D186=3D=3D Command: /home/eddy/work/dwarves-fork/build/pahole --ru=
nning_kernel_vmlinux
    =3D=3D186=3D=3D=20
    vmlinux
    =3D=3D186=3D=3D=20
    =3D=3D186=3D=3D HEAP SUMMARY:
    =3D=3D186=3D=3D     in use at exit: 8 bytes in 1 blocks
    =3D=3D186=3D=3D   total heap usage: 15 allocs, 14 frees, 21,408 bytes a=
llocated
    =3D=3D186=3D=3D=20
    =3D=3D186=3D=3D 8 bytes in 1 blocks are definitely lost in loss record =
1 of 1
    =3D=3D186=3D=3D    at 0x4843866: malloc (vg_replace_malloc.c:446)
    =3D=3D186=3D=3D    by 0x4A8F9AE: strdup (strdup.c:42)
    =3D=3D186=3D=3D    by 0x48755EC: vmlinux_path__find_running_kernel (dwa=
rves.c:2718)
    =3D=3D186=3D=3D    by 0x40ABBD: main (pahole.c:3720)
    =3D=3D186=3D=3D=20
    =3D=3D186=3D=3D LEAK SUMMARY:
    =3D=3D186=3D=3D    definitely lost: 8 bytes in 1 blocks
    =3D=3D186=3D=3D    indirectly lost: 0 bytes in 0 blocks
    =3D=3D186=3D=3D      possibly lost: 0 bytes in 0 blocks
    =3D=3D186=3D=3D    still reachable: 0 bytes in 0 blocks
    =3D=3D186=3D=3D         suppressed: 0 bytes in 0 blocks

While technically this is not a problem, maybe add a call to free()
just to avoid noise in valgrind output?
(Note that 'const' qualifier is no longer needed for
 vmlinux_path__find_running_kernel, as it returns strdup result).

> +
> +		return rc;
> +	}
> +
>  	if (languages.str && parse_languages())
>  		return rc;
> =20



