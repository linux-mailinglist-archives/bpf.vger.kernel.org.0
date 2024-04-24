Return-Path: <bpf+bounces-27673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBF28B088D
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 13:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F59E287EA6
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 11:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BF715AAAE;
	Wed, 24 Apr 2024 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpkS81q5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F10315A4A0
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959109; cv=none; b=JIn6qZvKfWqIuWrcYZSSGAO26lWo4cBd9FTHbnaAusSxbYiHGISjN3eR3pfyuhYnMRM6NjVKHeGaoUTL2bE0vAdUnSB2oeFQWZocRGIiraq38bGoLZ5F4axtKDAlWtzXb08h8G6/9+4t25K9oTIVBjli0HHe3WsUNho7styGlTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959109; c=relaxed/simple;
	bh=M+RZ4gYJDMarG5i0YRGOE2srlHZuTqU1dK4Cx0Uyf0U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibaw2H0rd7axO6vqzcXizlL3uoGMEDjmX2zbpwL55DHRA84ZB+Q8aLtLFZaCsJaeNvrMvADo07laa45SuWoV66jZ0zvOLvkN57FjpyZ61H9alNU+7qDaVUZ4JUYuzD1k5gLbF/B+oeIVtnq3Z/RFN66OC8QDqX8c6VPIXSJ7ShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpkS81q5; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57232e47a81so601705a12.0
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 04:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713959105; x=1714563905; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U12KRX7rOsMVpN08fOTZeBRgTrW81TGjrZBOSB5HzFk=;
        b=WpkS81q5c3IqhwBj6XNWUsel54+j5NFUpL44CWVvHw+qYlnTbMpNx+OAOGHMJPTBH4
         fvRT6rfh6FDIWU1T/8IdoenX1SOtYhH/uG9EG8cKYpbY4Ivjtfaca3i/Qlb8fut4bm8g
         UGYQRbIgxOgGLGcIfNlODDx83QBC5D6dimzrEmuyVfrKH69XDNolCXi0KIp69T+9bStn
         UXsCkF4b2JlJF+q0RdpLD51OZQeQefw5x5MlNFPwK0Hb7C0QakhKGrLE/YmjUhK3BOXT
         bl+cwmYgroBNOOkiizC+B63xVH9wmRdRR8nS8yiHanDBCKquX3yQ54073GMhJwSp2hKi
         PxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713959105; x=1714563905;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U12KRX7rOsMVpN08fOTZeBRgTrW81TGjrZBOSB5HzFk=;
        b=pc+HIOJez7OmTto0Yf75A+Mw507LKud/b8BtcblpFPHpRotwZG61P4GMgVA6rXgHun
         f/aS3AoD1X0Uu0tvD9ZYh7aaj1en2b6D6tZ5AlOpAYvKu8hPHbUdEzj/+Jtqt67DHl08
         OAM6HLFzJgj5mxnh1obSBBT8pmN3swdMZlXsGGHQxgHdJP09nGehoTJZQfJ+VE4D7XX2
         93VABdfvqLo/kYVHmjipB6ARexanrpcpR+cW+WRD91DFJ1RVstAXT2kI1KTttv3IhgtK
         My+JeELNfTszNIj2obWfb4DcLd/fMND6UiB0sUSNZG7AndK2ef843Ru+Yo1D1RkLWk5g
         0JNw==
X-Forwarded-Encrypted: i=1; AJvYcCU4szr52+Y7SImMPo2Q+/ePip+h0mvrSKWj3U/queKOgrECk2/41Tcu35I8+PxFf79hn3y97FOFNj9PI8h1vNiY68o3
X-Gm-Message-State: AOJu0YwE5ZrF8J5MEfFN3UrRQ1Sa9mOJNKZ1MQdxJcTi3Cc9XuX4AfJy
	n7m8uBC6QfljvPE8xYcUa/oZdgoiUBvkOscl/mkrhUQB84TJO4Mr
X-Google-Smtp-Source: AGHT+IHYubTNdLMQHWhBcws3bvgW7Kka7+eWzqfh0iGTC9fvZVb2/uaPP3AmcYQRIBaTaj+8zWUaLQ==
X-Received: by 2002:a05:6402:26c3:b0:572:34b9:8842 with SMTP id x3-20020a05640226c300b0057234b98842mr296126edd.13.1713959105578;
        Wed, 24 Apr 2024 04:45:05 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id u7-20020a509507000000b005722d871e4csm1079624eda.90.2024.04.24.04.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 04:45:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 24 Apr 2024 13:45:02 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Viktor Malik <vmalik@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH bpf-next 3/7] bpf: Add support for kprobe multi session
 cookie
Message-ID: <Zijwvg9dasUX-_Jx@krava>
References: <20240422121241.1307168-1-jolsa@kernel.org>
 <20240422121241.1307168-4-jolsa@kernel.org>
 <CAEf4BzY4PGHARcfB3DX1keDD5SaaMv1Rezz-2V_r5B4Hi9C9Jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY4PGHARcfB3DX1keDD5SaaMv1Rezz-2V_r5B4Hi9C9Jg@mail.gmail.com>

On Tue, Apr 23, 2024 at 05:26:51PM -0700, Andrii Nakryiko wrote:
> On Mon, Apr 22, 2024 at 5:13 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support for cookie within the session of kprobe multi
> > entry and return program.
> >
> > The session cookie is u64 value and can be retrieved be new
> > kfunc bpf_session_cookie, which returns pointer to the cookie
> > value. The bpf program can use the pointer to store (on entry)
> > and load (on return) the value.
> >
> > The cookie value is implemented via fprobe feature that allows
> > to share values between entry and return ftrace fprobe callbacks.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  kernel/bpf/verifier.c    |  7 +++++++
> >  kernel/trace/bpf_trace.c | 19 ++++++++++++++++---
> >  2 files changed, 23 insertions(+), 3 deletions(-)
> >
> 
> Had the same question as Alexei, but this read-write semantics quirk
> makes sense. But it's probably a bit more reliable and cleaner to
> handle it by special casing this kfunc a bit earlier (see
> KF_bpf_rbtree_add_impl) and setting r0_size = 8, r0_rdonly = false.
> And then let generic PTR -> INT logic kick in. You'll be futzing with
> register state much less.

ok, will try it this way

thanks,
jirka

> 
> Other than that looks good:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 68cfd6fc6ad4..baaca451aebc 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10987,6 +10987,7 @@ enum special_kfunc_type {
> >         KF_bpf_percpu_obj_drop_impl,
> >         KF_bpf_throw,
> >         KF_bpf_iter_css_task_new,
> > +       KF_bpf_session_cookie,
> >  };
> 
> [...]

