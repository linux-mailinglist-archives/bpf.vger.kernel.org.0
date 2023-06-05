Return-Path: <bpf+bounces-1816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C77722902
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 16:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AFBE2812BE
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BEE134A3;
	Mon,  5 Jun 2023 14:39:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9AA10FB
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 14:39:25 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D0C9E;
	Mon,  5 Jun 2023 07:39:23 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f4c264f6c6so6247399e87.3;
        Mon, 05 Jun 2023 07:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685975961; x=1688567961;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Hz800SSofiVXRvce9cLzbm3vIeZGwhyFOHVtLacVuZY=;
        b=cVvD+2YsNZw+BoKnR7/9gz/TrdXUcpojSG80vE+UREHCy91mTpMks/xhZh3IWmfagQ
         2d2WNzhDe0nnuGjaU/xq2+xqhRUBvWqGZ5dpv+n/bGAFIUCVPHFHcFe1UHmDQSPmmPD3
         vw+ztdVb3au1xLij4R/3Zap4snjsW027RzBeBcO6JoeVIe823vaFl7wmJc6MGPebdlh9
         anZ6NNY9Hg+2AZi5AiANB96bEU9wXwRKiWWiTCxWHD9vYCPCkCLowHQ2EOQJD9zWfcWj
         AdfW0haTRuH/11mZpHCzfjnhNNDgaiDOBeHtxJttm7behAFB6AVKLIScFKYFgR6Ss9/+
         bSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685975961; x=1688567961;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hz800SSofiVXRvce9cLzbm3vIeZGwhyFOHVtLacVuZY=;
        b=C9i6UplBoizoK4HwQBBia/hjyZqpHNziro7gZhjLcomiD1oG8XYsKs0AByKDDS0IoO
         eOCUwuF7Pa1mugiUhhmuD+RRxe1d5PHgtaH0AMaIE3sIV/yf7iFJPjNTL+M/klSJzR6P
         RDEQ2JOdTVntE6yoicb+wJeeg4jIwamoTHqepENgXeWprMAbPOSgPXZZXF4uARId5CfZ
         LFE1A2q2nBxTHdzEbTHnVyRAy4QcrSD2408xd9xPw+1DXsk6VDXcA/Tae4aR8H5hFpVU
         W53NRcKuOZnNmYuHZ+y4nM7Yl6gVEppecE8HioMtyVI+X4GAeajYRvZMQXDkDj0SoCkN
         yXDw==
X-Gm-Message-State: AC+VfDwyabn9ln9JXlGIUbwh/lrSfm5jKPElZBf4ag7a7VLrXPp8WNg0
	hFYV/skes2H4wcBd+BGa/W8=
X-Google-Smtp-Source: ACHHUZ4y1k8wH0169sXiu/C5oX8Rm/Q4loVRmNEY60RNoxodu9FqxghC9VzyFBtTQYmKD2AAlMdlSQ==
X-Received: by 2002:ac2:4e71:0:b0:4f2:5c4b:e699 with SMTP id y17-20020ac24e71000000b004f25c4be699mr5360645lfs.24.1685975961175;
        Mon, 05 Jun 2023 07:39:21 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id y9-20020ac255a9000000b004f5b7056455sm1145201lfg.114.2023.06.05.07.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 07:39:20 -0700 (PDT)
Message-ID: <2b4372428cd1e56de3b79791160cdd3afdc7df6a.camel@gmail.com>
Subject: Re: [PATCH dwarves] pahole: avoid adding same struct structure to
 two rb trees
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com, 
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com,
 mykolal@fb.com
Date: Mon, 05 Jun 2023 17:39:19 +0300
In-Reply-To: <ZH3nalodXmup6pEF@kernel.org>
References: <20230525235949.2978377-1-eddyz87@gmail.com>
	 <ZHnxsyjDaPQ7gGUP@kernel.org>
	 <a15b83ebc750df7edd84b76d30a72c50e016e80f.camel@gmail.com>
	 <ZHovRW1G0QZwBSOW@kernel.org>
	 <c9c1e04b10f0a13a3af9e980d04ce08d3304ac3a.camel@gmail.com>
	 <ZH3nalodXmup6pEF@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-06-05 at 10:47 -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Jun 02, 2023 at 09:08:51PM +0300, Eduard Zingerman escreveu:
> > On Fri, 2023-06-02 at 15:04 -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Fri, Jun 02, 2023 at 04:52:40PM +0300, Eduard Zingerman escreveu:
> > > > Right, you are correct.
> > > > The 'structures__tree =3D RB_ROOT' part is still necessary, though.
> > > > If you are ok with overall structure of the patch I can resend it w=
/o bzero().
>=20
> > > Humm, so basically this boils down to the following patch?
>=20
> > > +++ b/pahole.c
> > > @@ -674,7 +674,12 @@ static void print_ordered_classes(void)
> > >  		__print_ordered_classes(&structures__tree);
> > >  	} else {
> > >  		struct rb_root resorted =3D RB_ROOT;
> > > -
> > > +#ifdef DEBUG_CHECK_LEAKS
> > > +		// We'll delete structures from structures__tree, since we're
> > > +		// adding them to ther resorted list, better not keep
> > > +		// references there.
> > > +		structures__tree =3D RB_ROOT;
> > > +#endif
> =20
> > But __structures__delete iterates over structures__tree,
> > so it won't delete anything if code like this, right?
> =20
> > >  		resort_classes(&resorted, &structures__list);
> > >  		__print_ordered_classes(&resorted);
> > >  	}
>=20
> Yeah, I tried to be minimalistic, my version avoids the crash, but
> defeats the DEBUG_CHECK_LEAKS purpose :-\
>=20
> How about:
>=20
> diff --git a/pahole.c b/pahole.c
> index 6fc4ed6a721b97ab..e843999fde2a8a37 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -673,10 +673,10 @@ static void print_ordered_classes(void)
>  	if (!need_resort) {
>  		__print_ordered_classes(&structures__tree);
>  	} else {
> -		struct rb_root resorted =3D RB_ROOT;
> +		structures__tree =3D RB_ROOT;
> =20
> -		resort_classes(&resorted, &structures__list);
> -		__print_ordered_classes(&resorted);
> +		resort_classes(&structures__tree, &structures__list);
> +		__print_ordered_classes(&structures__tree);
>  	}
>  }
> =20

That would work, but I still think that there is no need to replicate call
to __print_ordered_classes, as long as the same list is passed as an argume=
nt,
e.g.:

@@ -670,14 +671,11 @@ static void resort_classes(struct rb_root *resorted, =
struct list_head *head)
=20
 static void print_ordered_classes(void)
 {
-       if (!need_resort) {
-               __print_ordered_classes(&structures__tree);
-       } else {
-               struct rb_root resorted =3D RB_ROOT;
-
-               resort_classes(&resorted, &structures__list);
-               __print_ordered_classes(&resorted);
+       if (need_resort) {
+               structures__tree =3D RB_ROOT;
+               resort_classes(&structures__tree, &structures__list);
        }
+       __print_ordered_classes(&structures__tree);
 }



