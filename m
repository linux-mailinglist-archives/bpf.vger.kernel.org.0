Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB2ACCE14
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2019 05:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfJFDjy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Oct 2019 23:39:54 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37240 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfJFDjy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Oct 2019 23:39:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id p1so4285712pgi.4
        for <bpf@vger.kernel.org>; Sat, 05 Oct 2019 20:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=A6Xzz8h3jprG5yMLVNGRiuwSLqmYMxwnuvvybwo0jeY=;
        b=jR7CqXe6b2Stl1ZEkA4Hgm/zvGlXWVhqwIusHN4P8wGpQFkbVrRZ8gRiOS5KHvXkqu
         +Ul7VR9pNGbb9ohlr8JKhhyTIcWeScClO1OSiR7BD9LowEL9rFizKBOxjoezbjVyATcg
         4yhCPucNc6UmWkD+DjGWgbZ27N0AjtFOTVy7dI0jNhF07zdoG4/98hGrDzKBxlwtD49I
         9fU0ZZYFRHPfW4hiTuVlkdakOZeRG3JRXj6ubX7MxzvC6ti8rnII+UwxPSIYIupNCVlF
         ZJwIhRiVHRIZBGls8XIdsWE4hb7jOsbvJ5ekiUH5rBhbfT1U1DOWDIALlNTaHJuYZVzo
         6FqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=A6Xzz8h3jprG5yMLVNGRiuwSLqmYMxwnuvvybwo0jeY=;
        b=qNDWtxIEGtPB7YGtrMrg+9JDakU5wIFceXEKK1vJjGEz82tmcsGBmIWMZPbqiKrc3+
         583Sqy6pCf3SZgk9myHJGN7f3aLAsRUV4mOGwOhGlI9w1n3rOnfaSbxaTc8LLoZj7Am/
         xoB6DdiWEZ1iyloZPTKQOZsF9EQHUjlBNDxiH3ZaYvzahnEFp5WHsWPddacun1UQ9whF
         /iSurh5VsVNNAeIE8K7okKgqU4rX5dkEUfSWy6g+7Bt1RfpRUOVgUS61/8++uBRKgixV
         h7kC4YJj3v5ZUcsSs4kpFACkC5CgvOHm+/jBY3oVeV0lAh1rESgwbLYfVrXYNgTsdDY8
         yQUQ==
X-Gm-Message-State: APjAAAW28V6Xv/4FhhFLo0BRpqOCs1zFtZHcDwupBsk+dQ5/JkGFp3/X
        Jse6YkVBOAvk59wpUUCQAMPsFw==
X-Google-Smtp-Source: APXvYqxta051mJnLmLeCQHg8Pr7mY9Ji6/vaY0vdtvk/b6/9Uk3zRFbWBvH3CCNq5pLS/Dv/9iPFJw==
X-Received: by 2002:a63:214e:: with SMTP id s14mr23129345pgm.205.1570333193337;
        Sat, 05 Oct 2019 20:39:53 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id k5sm9399827pgb.11.2019.10.05.20.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2019 20:39:53 -0700 (PDT)
Date:   Sat, 5 Oct 2019 20:39:45 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Support injecting chain calls into
 BPF programs on load
Message-ID: <20191005203945.6b3845a9@cakuba.netronome.com>
In-Reply-To: <87d0fbo58l.fsf@toke.dk>
References: <157020976030.1824887.7191033447861395957.stgit@alrua-x1>
        <157020976144.1824887.10249946730258092768.stgit@alrua-x1>
        <20191004161715.2dc7cbd9@cakuba.hsd1.ca.comcast.net>
        <87d0fbo58l.fsf@toke.dk>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 05 Oct 2019 12:29:14 +0200, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> >> +static int bpf_inject_chain_calls(struct bpf_verifier_env *env)
> >> +{
> >> +	struct bpf_prog *prog =3D env->prog;
> >> +	struct bpf_insn *insn =3D prog->insnsi;
> >> +	int i, cnt, delta =3D 0, ret =3D -ENOMEM;
> >> +	const int insn_cnt =3D prog->len;
> >> +	struct bpf_array *prog_array;
> >> +	struct bpf_prog *new_prog;
> >> +	size_t array_size;
> >> +
> >> +	struct bpf_insn call_next[] =3D {
> >> +		BPF_LD_IMM64(BPF_REG_2, 0),
> >> +		/* Save real return value for later */
> >> +		BPF_MOV64_REG(BPF_REG_6, BPF_REG_0),
> >> +		/* First try tail call with index ret+1 */
> >> +		BPF_MOV64_REG(BPF_REG_3, BPF_REG_0), =20
> >
> > Don't we need to check against the max here, and spectre-proofing
> > here? =20
>=20
> No, I don't think so. This is just setting up the arguments for the
> BPF_TAIL_CALL instruction below. The JIT will do its thing with that and
> emit the range check and the retpoline stuff...

Sorry, wrong CPU bug, I meant Meltdown :)

https://elixir.bootlin.com/linux/v5.4-rc1/source/kernel/bpf/verifier.c#L9029

> >> +		BPF_ALU64_IMM(BPF_ADD, BPF_REG_3, 1),
> >> +		BPF_RAW_INSN(BPF_JMP | BPF_TAIL_CALL, 0, 0, 0, 0),
> >> +		/* If that doesn't work, try with index 0 (wildcard) */
> >> +		BPF_MOV64_IMM(BPF_REG_3, 0),
> >> +		BPF_RAW_INSN(BPF_JMP | BPF_TAIL_CALL, 0, 0, 0, 0),
> >> +		/* Restore saved return value and exit */
> >> +		BPF_MOV64_REG(BPF_REG_0, BPF_REG_6),
> >> +		BPF_EXIT_INSN()
> >> +	}; =20
