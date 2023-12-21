Return-Path: <bpf+bounces-18504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0B581AF57
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 08:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3354B230B2
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 07:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837BDD2E1;
	Thu, 21 Dec 2023 07:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LleBpi+w"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE7156C3
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703143426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S5iQ5Rxhg2tY1zdXpfTYhKOCTGWvTSDlEblG2q97v7A=;
	b=LleBpi+w7hfz7nEqkuUMwqp+962aIvSeE7OCknNxFfsEi6Yi0icuToF759ar7Emd4SUTAJ
	e39qXCDe/XDxuPa2PKnUFF9fLt0slOtiZfoqfPC0Je5n2ltY2QTH2HWJ8Nsgqk1UvqrT4Z
	LiV/ZPeKEWG8fPmWAVu+/iv4O7LwDB8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-4_PnelCQM-yU3gBr7ANYTg-1; Thu, 21 Dec 2023 02:23:43 -0500
X-MC-Unique: 4_PnelCQM-yU3gBr7ANYTg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a232f069e60so4621366b.1
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 23:23:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703143423; x=1703748223;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S5iQ5Rxhg2tY1zdXpfTYhKOCTGWvTSDlEblG2q97v7A=;
        b=KQw0AowXVKcip6xt+TyQ7KlXLPk5/VMfZTCBcwDVjEl84td8P3TIuwn/moiwnyEQb7
         YrxYVjSZ2ICYJJiyfdJ8q5cMKNt+SsbiIfNGljDgA1PMehmPtJL7BUxxpWzm+FKD+0qD
         n27hsFHvbY+xMU9sJEHkgdjLGXtqXvNK/L/9QltHwC5TCIdpJL+1nHWGu5FUqcLLQ9mF
         Yxx0fxsPN4T06zY6Jaa1Gucw6eKegWu59ul/0SctulEQtnxkNbxmwYdqftT4gV2GXuaP
         iCxOAfMGl36S9fP64CcWxjJz4Fq2+kboFt6/9xnWfu6sxVakR/nDe6zMJd892lcXoy6u
         W1TA==
X-Gm-Message-State: AOJu0YyOa0qgnY0Kz0R7Z7Z1DkJ1sPSWX/7MMfX1TpzWOTY+vt8NlKhl
	/5+83yO+hqLvdNKMHhdLE9ZBhKhrYhwP9welemnwnyLwRxTvUnp14PaWzN8edyL+S4UjPka3qTE
	naRDqtHMTI+p+
X-Received: by 2002:a17:907:d109:b0:a1e:3c8f:bc9e with SMTP id uy9-20020a170907d10900b00a1e3c8fbc9emr23223342ejc.0.1703143422830;
        Wed, 20 Dec 2023 23:23:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJlrKEtTtOyCKehzFoJjXimAif6KDElEO473ECyE4PhiXX1tTJ3lp/aIKEunA4mCeIyZAo2Q==
X-Received: by 2002:a17:907:d109:b0:a1e:3c8f:bc9e with SMTP id uy9-20020a170907d10900b00a1e3c8fbc9emr23223329ejc.0.1703143422464;
        Wed, 20 Dec 2023 23:23:42 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-246-124.dyn.eolo.it. [146.241.246.124])
        by smtp.gmail.com with ESMTPSA id j26-20020a170906411a00b00a26aaad6618sm82483ejk.35.2023.12.20.23.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 23:23:41 -0800 (PST)
Message-ID: <3830bef7b52414e3a0b874d3fd23d7e8bc4c1c2f.camel@redhat.com>
Subject: Re: [PATCH net 3/3] ice: Fix PF with enabled XDP going no-carrier
 after reset
From: Paolo Abeni <pabeni@redhat.com>
To: "Nelson, Shannon" <shannon.nelson@amd.com>, Larysa Zaremba
	 <larysa.zaremba@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, netdev@vger.kernel.org, 
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bpf@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Simon
	Horman <horms@kernel.org>, Chandan Kumar Rout <chandanx.rout@intel.com>
Date: Thu, 21 Dec 2023 08:23:39 +0100
In-Reply-To: <e24ad563-f814-490f-8659-af6ff15cdbc0@amd.com>
References: <20231218192708.3397702-1-anthony.l.nguyen@intel.com>
	 <20231218192708.3397702-4-anthony.l.nguyen@intel.com>
	 <18b686c6-aec1-41ce-8d9c-572667c9a738@amd.com>
	 <ZYKypxfcfwTjZQ8w@lzaremba-mobl.ger.corp.intel.com>
	 <e24ad563-f814-490f-8659-af6ff15cdbc0@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-20 at 09:04 -0800, Nelson, Shannon wrote:
> On 12/20/2023 1:23 AM, Larysa Zaremba wrote:
> >=20
> > On Tue, Dec 19, 2023 at 04:09:09PM -0800, Nelson, Shannon wrote:
> > > On 12/18/2023 11:27 AM, Tony Nguyen wrote:
> > > > Caution: This message originated from an External Source. Use prope=
r caution when opening attachments, clicking links, or responding.
> > > >=20
> > > >=20
> > > > From: Larysa Zaremba <larysa.zaremba@intel.com>
> > > >=20
> > > > Commit 6624e780a577fc596788 ("ice: split ice_vsi_setup into smaller
> > > > functions") has refactored a bunch of code involved in PFR. In this
> > > > process, TC queue number adjustment for XDP was lost. Bring it back=
.
> > > >=20
> > > > Lack of such adjustment causes interface to go into no-carrier afte=
r a
> > > > reset, if XDP program is attached, with the following message:
> > > >=20
> > > > ice 0000:b1:00.0: Failed to set LAN Tx queue context, error: -22
> > > > ice 0000:b1:00.0 ens801f0np0: Failed to open VSI 0x0006 on switch 0=
x0001
> > > > ice 0000:b1:00.0: enable VSI failed, err -22, VSI index 0, type ICE=
_VSI_PF
> > > > ice 0000:b1:00.0: PF VSI rebuild failed: -22
> > > > ice 0000:b1:00.0: Rebuild failed, unload and reload driver
> > > >=20
> > > > Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functio=
ns")
> > > > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > Reviewed-by: Simon Horman <horms@kernel.org>
> > > > Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Continge=
nt Worker at Intel)
> > > > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > > > ---
> > > >    drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
> > > >    1 file changed, 3 insertions(+)
> > > >=20
> > > > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net=
/ethernet/intel/ice/ice_lib.c
> > > > index de7ba87af45d..1bad6e17f9be 100644
> > > > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > > > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > > > @@ -2371,6 +2371,9 @@ static int ice_vsi_cfg_tc_lan(struct ice_pf *=
pf, struct ice_vsi *vsi)
> > > >                   } else {
> > > >                           max_txqs[i] =3D vsi->alloc_txq;
> > > >                   }
> > > > +
> > > > +               if (vsi->type =3D=3D ICE_VSI_PF)
> > > > +                       max_txqs[i] +=3D vsi->num_xdp_txq;
> > >=20
> > > Since this new code is coming right after an existing
> > >                if (vsi->type =3D=3D ICE_VSI_CHNL)
> > > it looks like it would make sense to make it an 'else if' in that las=
t
> > > block, e.g.:
> > >=20
> > >                if (vsi->type =3D=3D ICE_VSI_CHNL) {
> > >                        if (!vsi->alloc_txq && vsi->num_txq)
> > >                                max_txqs[i] =3D vsi->num_txq;
> > >                        else
> > >                                max_txqs[i] =3D pf->num_lan_tx;
> > >                } else if (vsi->type =3D=3D ICE_VSI_PF) {
> > >                        max_txqs[i] +=3D vsi->num_xdp_txq;
> >=20
> > Would need to be
> >          max_txqs[i] =3D vsi->alloc_txq + vsi->num_xdp_txq;
> >=20
> > >                } else {
> > >                        max_txqs[i] =3D vsi->alloc_txq;
> > >                }
> > >=20
> > > Of course this begins to verge on the switch/case/default format.
> > >=20
> > > sln
> > >=20
> >=20
> > I was going for logic: assign default values first, adjust based on ena=
bled
> > features (well, a single feature) second. The thing that in my opinion =
would
> > make it more clear would be replacing 'vsi->type =3D=3D ICE_VSI_PF' wit=
h
> > ice_is_xdp_ena_vsi(). Do you think this is worth doing?
>=20
> Hmm... I made a dumb error in a quick read of the code.  This suggests=
=20
> that making the intent of the code more clear would be a good idea.  I=
=20
> think that the ice_is_xdp_ena_vsi() would definitely make it more clear=
=20
> as opposed to the bare ICE_VCSI_PF.

I think that the current patch fits well for stable, and the issue
looks relevant enough that we should prefer have it fixed in this
cycle. Any refactoring/change would not allow such result due to the
timing.

I'll apply the series as-is, please follow-up on net-next as needed (no
rush).

Cheers,

Paolo


