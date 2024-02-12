Return-Path: <bpf+bounces-21734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DD085170B
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 15:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47491C21715
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 14:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA7E3AC14;
	Mon, 12 Feb 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="r9U9a1Pw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F2118646
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748251; cv=none; b=YVF2P3kdm2EPFQs1xSARPf8j53kEQ6d4eLFU3+FmcJrAUh/q+8K/GapDbyXHn14ldDBqRAk0miKjvvMfkGy6VJ/Er8PBnSJQckqATdGGFJS9w8MVT71fsJZceCzRXv3d9hLv/KnLGkyvyzyCvMpi0xMPROvDYvDaxwsl2EWzGf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748251; c=relaxed/simple;
	bh=p9vOfnePUV1vkqui1jKfajElpdn9UJuYx8Lvstoz6CI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZ6+AMZkOOlhid+QO6g0HrJ//MCupBaiKSCGUbx+0m6sdO7H7uU7qg/xxpcp9TuZgOGXBw9mDsrptnEXKe4Vuw9EZaePJxxtGQjyq0WYZ8SDNfcmzLrv/PiOlMAODs3X/NWLim1plovv1cFowH8bNTmOyaBVEFptH4Pm6HfSfxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=r9U9a1Pw; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6049e8a54b5so32487297b3.0
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 06:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1707748248; x=1708353048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHfkimgnQqa9pmxY7xUwBKCcRRo2tt3mrL+Jov7rDrk=;
        b=r9U9a1Pw73I69igyrW9NlH78GGf5gDZmZKKgnw6XWrNLiiMNqaSQNDy2QC3h5P4Uxb
         VXqfE21VeNRMcrQHYMqOX5RWlU+3x/z7FJcnusOiRxIu7Bfu/mC4iaNWEqhWgI1Phgzn
         jDFGH0Spl0dfM6R5TN8d24wMLyotgqvfYhJHUqSCk3flNzMrKKA/qyuJGC7YfGcUAqbT
         l29o75QeuEFg7vPZ/amcg+3Pa0gVnoYAcQcCJfpQqclhv0qbTTwTgLHvtdE4UGY2yKcu
         +iW/SXgG2Eu9eLRRX8mWus1wVk84QVuMClHzK6tKVUKyuIDflG5WZp18Z7LXHa69UZ5n
         WCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707748248; x=1708353048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHfkimgnQqa9pmxY7xUwBKCcRRo2tt3mrL+Jov7rDrk=;
        b=iamYdlLDGB1TcOz8oX0tZPwYeOzR1I7A0qJ5jGYNoqbUe3rrcSzkcWCVsHLI2QAKyh
         KbIPTBjY4Nun1+U/GI+eg8Yxr7ynpEt0mJSKbp0lVwDzLXz/M8Wqs/Xtp0Y2eZS1BClK
         Zg/uf0I7yqAZjGK7KwJ0oD969ku63gkd1NlRIZwOY7gJpzCRhxNF2dzg7iy/npD0p86d
         m3iQr6jqatj2lJ2FruEWEiZDfV+jSeqkdL1BVnNp88jvW+drG827lXMDmFvcnqzbnJAn
         MOdtyuIzVFH6EtuEY85yqhlTM/Z+zQsjhAJLzjx2B7jUDYLveQd8sFn4l9mDCtAVHRBW
         FpNg==
X-Forwarded-Encrypted: i=1; AJvYcCWmaOiOE7hcOWQvUlhNjqwhstcVdmbjhL4wpdQPq2Q26zf49u3v0e8Z2piitkaCtxa3tyqBgE1laxygKoKFP76NW69f
X-Gm-Message-State: AOJu0Yzekgm5WgiEm6wJQLObpSX9YHnkUFhKkz8VNGn7Sm8o+bK7/SM+
	umwhkwDNopbup1mds5cVd/Tzzvh5wuVfYy0DVY9dij2rnvrNZSUph877pKjmiC4q9YPbkK9FORP
	VheJnmxd5Mm5ZNVfThTDMlnlxkHfK/lj/lVMw
X-Google-Smtp-Source: AGHT+IGgkXOeWFRC0kD8AvUJh5gqRcJZ7vXLyuTDLZrRPmueX7K9FwVydl54BFjd7DYsYX8pFLa/WxHERXEmf4eoHgk=
X-Received: by 2002:a0d:dc07:0:b0:604:92e0:c76f with SMTP id
 f7-20020a0ddc07000000b0060492e0c76fmr6197823ywe.30.1707748248046; Mon, 12 Feb
 2024 06:30:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-9-jhs@mojatatu.com>
 <CALnP8ZZAjsnp=_NhqV6XZ5EaAO-ZKOc=18aHXnRGJvvZQ_0ePg@mail.gmail.com>
In-Reply-To: <CALnP8ZZAjsnp=_NhqV6XZ5EaAO-ZKOc=18aHXnRGJvvZQ_0ePg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 12 Feb 2024 09:30:36 -0500
Message-ID: <CAM0EoM=CKAGm=qi0pxAvJBOR0aQyHDR4OkBsfyg+DcaQqOUD6g@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 08/15] p4tc: add template pipeline create,
 get, update, delete
To: Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 3:44=E2=80=AFPM Marcelo Ricardo Leitner
<mleitner@redhat.com> wrote:
>
> On Mon, Jan 22, 2024 at 02:47:54PM -0500, Jamal Hadi Salim wrote:
> > @@ -39,6 +55,27 @@ struct p4tc_template_ops {
> >  struct p4tc_template_common {
> >       char                     name[P4TC_TMPL_NAMSZ];
> >       struct p4tc_template_ops *ops;
> > +     u32                      p_id;
> > +     u32                      PAD0;
>
> Perhaps __pad0 is more common. But, is it really needed?
>

$ pahole -C p4tc_template_common net/sched/p4tc/p4tc_tmpl_api.o
struct p4tc_template_common {
        char                       name[32];             /*     0    32 */
        struct p4tc_template_ops * ops;                  /*    32     8 */
        u32                        p_id;                 /*    40     4 */
        u32                        PAD0;                 /*    44     4 */

        /* size: 48, cachelines: 1, members: 4 */
        /* last cacheline: 48 bytes */
};

Looks good for 64b alignment. We can change the name.

> > +};
>
> Only nit.
>
> Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

Thanks for this and all the other reviews. Much appreciated!

cheers,
jamal

