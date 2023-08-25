Return-Path: <bpf+bounces-8656-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A94788D3F
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 18:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB34281873
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 16:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB81B17AD5;
	Fri, 25 Aug 2023 16:41:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A8B1079A
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 16:41:07 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0CE2121
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:41:06 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so16805691fa.3
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 09:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692981664; x=1693586464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HLZqQ958UCIPJMBNHru6Bi+kQtvUWgVl3oCWYPC/o8=;
        b=PsIZrHOneM+JhyqxAaI9wxoVy/SYO4FKPzaWenV8f/GScbnIXBDLjvnqG1rNexGALy
         VlvIM0A2NsP/hvW4dsexpmpnaffGd10XJSHiVgX929ADKmFsWkxDeqs5zwyNTmOVtDKg
         eDEtOxZ4Ab0yrQFla8weKO5LodfD+7D5NVV4kDfPbb0FUgWlCtW/43SU2NIcTfjBGdZW
         eNOr7M14ZDxZ2u04YOpJmV1PrhG47fQoxsom5aCUm7QHR24b1QfwgzxtUA/MBCxAaN8O
         3+ENZarmkJp2Cf78lDuHE48DcoCC2uqw8SjgHiV5b/vQknWYv30sAOkOnbNCIHXbVY2f
         wr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692981664; x=1693586464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HLZqQ958UCIPJMBNHru6Bi+kQtvUWgVl3oCWYPC/o8=;
        b=gFZLE/2hzlqIsp3FwPZCo+l1KXnwiP1YA2PwMF2M5Zl/NyxNUj3xBsr9jQFsO6sntX
         Ly/b5ZI4wmV4c0KWWTWCW7lt9t2AXEGcmTg6JRpgJQKBdwKxeODiHm99YpEH8/pd7t7G
         BwiF+42JOT8bvom89LknozGHw3H/em4Se3BT6kON9dQBoZBYPormodjiQvdsW03rGMn8
         EZlE18Qk/gSYPDgJQbugz0xiMSAdbP/10SuYH3K36FQ1KqWYWDG2x+inym5c4smBlzNs
         1r4BxhglDl6rYEmfwijyzvb+qV/PXa4WjQ6URBuac4BkOxCkf+YsmmK9/Qiq+v3wdxVC
         f6zw==
X-Gm-Message-State: AOJu0YzgJNy+Tzcy/g8aPLlPD7UKpQbEiG73spWS/t0J0ZhERiD25pXZ
	IzQ7v6ltfgMbrRxf7gZrm3vc/Va5qL0vYn/St728Nyltxzfa8g==
X-Google-Smtp-Source: AGHT+IHOBNdWmp2LU67bSFZqhOiBL3zl3wtqBaiFZAy/gUUMRqZlZUSdbpTfN/HNCyUrx3JYuknG4hZbmZ5Lrqzj74g=
X-Received: by 2002:a2e:9211:0:b0:2b6:cf6f:159e with SMTP id
 k17-20020a2e9211000000b002b6cf6f159emr14055826ljg.44.1692981664003; Fri, 25
 Aug 2023 09:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230824220907.1172808-1-awerner32@gmail.com> <a811af2f-3c5d-64dc-c49a-f865b2de9967@huaweicloud.com>
 <94944fe2-a085-d171-8947-a62d84e0daf4@iogearbox.net>
In-Reply-To: <94944fe2-a085-d171-8947-a62d84e0daf4@iogearbox.net>
From: Andrew Werner <awerner32@gmail.com>
Date: Fri, 25 Aug 2023 12:40:52 -0400
Message-ID: <CA+vRuzPsb3FeoxB4C9oncfLB3bxhKue9pHMxqvC9WOzP9CKi7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] libbpf: handle producer position overflow
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org, 
	kernel-team@dataexmachina.dev, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, olsajiri@gmail.com, void@manifault.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 12:00=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> On 8/25/23 5:17 AM, Hou Tao wrote:
> > On 8/25/2023 6:09 AM, Andrew Werner wrote:
> >> Before this patch, the producer position could overflow `unsigned
> >> long`, in which case libbpf would forever stop processing new writes t=
o
> >> the ringbuf. Similarly, overflows of the producer position could resul=
t
> >> in __bpf_user_ringbuf_peek not discovering available data. This patch
> >> addresses that bug by computing using the signed delta between the
> >> consumer and producer position to determine if data is available; the
> >> delta computation is robust to overflow.
> >>
> >> A more defensive check could be to ensure that the delta is within
> >> the allowed range, but such defensive checks are neither present in
> >> the kernel side code nor in libbpf. The overflow that this patch
> >> handles can occur while the producer and consumer follow a correct
> >> protocol.
> >>
> >> Secondarily, the type used to represent the positions in the
> >> user_ring_buffer functions in both libbpf and the kernel has been
> >> changed from u64 to unsigned long to match the type used in the
> >> kernel's representation of the structure. The change occurs in the
> >> same patch because it's required to align the data availability
> >> calculations between the userspace producing ringbuf and the bpf
> >> producing ringbuf.
> >
> > Because the changes include both the change for ring buffer and user
> > ring buffer. I think it is better to split the changes into three
> > patches to ease the backports of these changes: one patch for change in
> > libbpf for ring buffer, and another two patches for changes in libbpf
> > and kernel for user ring buffer.
>
> Splitting off the kernel parts into a separate patch would indeed be
> good so that stable team can pull it. (Pls also add a Fixes tag.)

Ack, will do this for the next revision when the dust settles.

>
> Thanks,
> Daniel

