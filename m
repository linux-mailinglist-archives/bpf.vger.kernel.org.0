Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9932220EB
	for <lists+bpf@lfdr.de>; Thu, 16 Jul 2020 12:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGPKuO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jul 2020 06:50:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23429 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726506AbgGPKuM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jul 2020 06:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594896610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b1gMoXuEBwCohMO/2xIeqx9uuqCaWy4LMCiJ13+Zc+8=;
        b=WhEo5S27V5OeYSfSVj7L1qq4IqDrOpR/YO39FOk6c8WOWe6jhxIf5NmFtC91FVnCOky9c7
        f3kyOOLDfqXWLegqpE+haAeOsZgMYSfEIxIg6RLphmZRjzVyMvwo8u+RxsI09L+LRYfNMZ
        XirNXtuZS456O1uul5iysylxbofTa6M=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-VANEZjmZN9-ksgABzxCV4Q-1; Thu, 16 Jul 2020 06:50:09 -0400
X-MC-Unique: VANEZjmZN9-ksgABzxCV4Q-1
Received: by mail-io1-f71.google.com with SMTP id b133so3343888iof.1
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2020 03:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=b1gMoXuEBwCohMO/2xIeqx9uuqCaWy4LMCiJ13+Zc+8=;
        b=kU1SZeZ3KHr2eRvbT1GSHvBM9qtbD6Fx/BLzmPHucTDIrHIMaPfTM9GvkIa642AU5v
         6QYw1ORFbuYiYyLClYkikNb+J6q7E1jtEhfHIdI4rSGnqwNLB/LiAJ3fS1xN6nYNtfJr
         nCwUXK0FcDb6VsFwTBYyvZs4a/YdNDnmgVx6r94IMoStQ5WA3OSpmlooWRmt++Wk8DjS
         ogoqmd6EcBNI2Pi7e7Spv7D9sLgHJOxwm8L6KIcBup5kXvSTbUPOHypXiJLNHzNR+iJ9
         yp1sag1+pYtbeXP21iT3F6Ez7EJ5PbnYYR1aaf1bE2Id+FLYm7eTNK47eQHHIekrezrQ
         O0RA==
X-Gm-Message-State: AOAM533jkPc5EWJ2rrAx1Vu6b8acTlpD3GqXrYVL0/2Xt7bbMREKXJ6I
        wYSFk4h8qAht/TBYAbZQG+h3s9+XrBOOgZX6vy+T0aSgU3slwYtfry1YzeGO2hbEYUUO51PCuJ9
        OFqlhGv/iiy9W
X-Received: by 2002:a92:c689:: with SMTP id o9mr4016041ilg.302.1594896608911;
        Thu, 16 Jul 2020 03:50:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1zLNYUo4Wd4ijr45ZomUI+kOWdjdW1J1naK8ousx3hWzgKatPBp0on0UpzHek3akYBNABZg==
X-Received: by 2002:a92:c689:: with SMTP id o9mr4016010ilg.302.1594896608606;
        Thu, 16 Jul 2020 03:50:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id m2sm2506893iln.1.2020.07.16.03.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 03:50:07 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 302EC1804F0; Thu, 16 Jul 2020 12:50:05 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 3/6] bpf: support attaching freplace programs to multiple attach points
In-Reply-To: <20200715204406.vt64vgvzsbr6kolm@ast-mbp.dhcp.thefacebook.com>
References: <159481853923.454654.12184603524310603480.stgit@toke.dk> <159481854255.454654.15065796817034016611.stgit@toke.dk> <20200715204406.vt64vgvzsbr6kolm@ast-mbp.dhcp.thefacebook.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 16 Jul 2020 12:50:05 +0200
Message-ID: <87mu3zentu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Wed, Jul 15, 2020 at 03:09:02PM +0200, Toke H=C3=83=C6=92=C3=82=C2=B8i=
land-J=C3=83=C6=92=C3=82=C2=B8rgensen wrote:
>>=20=20
>> +	if (tgt_prog_fd) {
>> +		/* For now we only allow new targets for BPF_PROG_TYPE_EXT */
>> +		if (prog->type !=3D BPF_PROG_TYPE_EXT ||
>> +		    !btf_id) {
>> +			err =3D -EINVAL;
>> +			goto out_put_prog;
>> +		}
>> +		tgt_prog =3D bpf_prog_get(tgt_prog_fd);
>> +		if (IS_ERR(tgt_prog)) {
>> +			err =3D PTR_ERR(tgt_prog);
>> +			tgt_prog =3D NULL;
>> +			goto out_put_prog;
>> +		}
>> +
>> +	} else if (btf_id) {
>> +		err =3D -EINVAL;
>> +		goto out_put_prog;
>> +	} else {
>> +		btf_id =3D prog->aux->attach_btf_id;
>> +		tgt_prog =3D prog->aux->linked_prog;
>> +		if (tgt_prog)
>> +			bpf_prog_inc(tgt_prog); /* we call bpf_prog_put() on link release */
>
> so the first prog_load cmd will beholding the first target prog?
> This is complete non starter.
> You didn't mention such decision anywhere.
> The first ext prog will attach to the first dispatcher xdp prog,
> then that ext prog will multi attach to second dispatcher xdp prog and
> the first dispatcher prog will live in the kernel forever.

Huh, yeah, you're right that's no good. Missing that was a think-o on my
part, sorry about that :/

> That's not what we discussed back in April.

No, you mentioned turning aux->linked_prog into a list. However once I
started looking at it I figured it was better to actually have all this
(the trampoline and ref) as part of the bpf_link structure, since
logically they're related.

But as you pointed out, the original reference sticks. So either that
needs to be removed, or I need to go back to the 'aux->linked_progs as a
list' idea. Any preference?

>> +	}
>> +	err =3D bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
>> +				      &fmodel, &addr, NULL, NULL);
>
> This is a second check for btf id match?
> What's the point? The first one was done at load time.
> When tgt_prog_fd/tgt_btf_id are zero there is no need to recheck.

It's not strictly needed if tgt_prog/btf_id is not set, but it doesn't
hurt either; and it was convenient to reuse it to resolve the func addr
for the trampoline + it means everything goes through the same code path.

> I really hope I'm misreading these patches, because they look very raw.

I don't think you are. I'll admit to them being a bit raw, but this was
as far as I got and since I'll be away for three weeks I figured it was
better to post them in case anyone else was interested in playing with
it.

So if anyone wants to pick these patches up while I'm gone, feel free;
otherwise, I'll get back to it after my vacation :)

-Toke

