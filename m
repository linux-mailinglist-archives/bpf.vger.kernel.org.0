Return-Path: <bpf+bounces-74747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E9BC6508E
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 17:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BE204E6CC1
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 16:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7972C0F9C;
	Mon, 17 Nov 2025 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X24Peyfv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354552BF3DF
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395547; cv=none; b=TBjaJhrpyCLjTrBVW0c4/CmcNHVuxoPhtwJsjVjB5acxHCstONobjGBz2FxpmX+KSQIIr4eRAgJ4pQRkyEWv87hlpRRAZ8gvbX75hVgvA0OrWpXxGJyCNWGH+3d9eM63Lec6sfEtjvpAmuuajHmG7PAgcwkp28qwuwSgqL2d2ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395547; c=relaxed/simple;
	bh=UXuVTbFZfxhi/CrUJ0m3gOEFVfhuQjoRzNtauAvd7JQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=FhhHm342L8TLC1yrMiaSoZICRbd3R0doJoTNguBX+O9XVgR/F9KhjIdui+zb1CFkLJ66fXmchjVV40OItONQoJCNMvXAcV6lFmY7drB5FDt0PfjaXhTXr1btypRkNekkiQwlI7BG+Q2Ng+ab5jQRial/KrhFdhIHgy8peC3KfNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X24Peyfv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so20695265e9.3
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 08:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763395543; x=1764000343; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dv25gH3/0ppvFW0ahX017ugBnCLfGg5eMQGqgnwTcyQ=;
        b=X24PeyfvRZp2RguBNMgmmF+dVokStvtag656iu8St9CqCe79eMN5BaHNgrT1kEz0Re
         YtoMq8JQHOv8s5E9ywpCAedbwzVzfQxcNEVrx/0w+QYl2LW11yiD/BlHJWW/D+KyvbG+
         6iKtcgcjMnNLNnuQUw1VLrLPSDo1VGCCrdR8jLl6/Cx3Z//Ef4dE/yENUSurAuVs5bBR
         odXsnGPqSFdpxiXp0nx6KSURVdV3JWRwZeV9TI5buLjD8DRVC04CIZLa+GpnoCkk3OaE
         Nr4p856KEqm+xhsxW2jNGF4OMj6Th6wrIvrnA6vBR8lJvUiUaRoSm+TFMOhZ+I8fLWIV
         Gqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763395543; x=1764000343;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dv25gH3/0ppvFW0ahX017ugBnCLfGg5eMQGqgnwTcyQ=;
        b=YY+FUS7lht/eSUx7tfCoO54hS41ecg7oczAVIyWB937PMVyjpJCBEwO7cqRwWnO2bW
         LlXGXEF64z/sg9nAh4GoW9sKmDCAI53XC83+gjXq4kvY04yfZ45H+5J3UZiF2QcoaAD/
         23i3srsbdphTTKpc30jJc3E6V9KP2Vcf7hyMNpDGPHRSez7CI5W1Kf7Xfho9d6wWcilH
         WqC3jcHMvmfctak0IuzfqsH+YleQks+Drch+RS30vV1D3gOPatcqjlTFpdf0eHmJNnt4
         XbUYKaECySOIEdK+LuDNGzG3ej7/PYkuuQUfCCZUrA3wceHXU9AQ3f9bLJF/26z2CRNo
         Omgg==
X-Forwarded-Encrypted: i=1; AJvYcCXiNQgiIfBtxTfeLfkuTu5JmoZDH9tbWEcgDdDwV2XA7Q/WSv5ZdhS5YIglPVEXXQu6juw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywky7pFdd6aznWffWT8/YkLif61AbUJtglHp20iuCDT6CeIwsDw
	Sp4JuWO9FvnPW7kHoy1Hgd44AnuSrmU/HhT3if6gfA3CGuP2NWal9waYd/p849ke
X-Gm-Gg: ASbGncsLtNcLie8jtHAYc1GofiY+SBZ0bdyFCuouCio+BwGgstAzoXJmA/yszVXNRki
	SqIi/JVh30O2YzriSYknCFeCFYR94seDhT6XRncffrH3mhiRrD+fhOZvaKeQEPI3BsNfrwFN97m
	XKKohz40ER7ipHfkxGNdrnLBlcqb4nLBIJyiu0RqBr8HcareRe4vydJcy/enZsl1HpS+cNTIpkt
	02rV6g23YIUgRoiaPFvTtjif+qXMQGO5z2fHFXIjpkKK5P9fERLdsHGEcwJRGhFPdi0/jFg/18b
	mmIujUAot1OItJZreTJafS1DD3Q4p4ODv987aO5aC7omd1ukqrBuznnfdxqvKRxpWPvtyCYsUIf
	kWUq4J9Olfub9jDaZpUCS67ZwwKVpYWHsB1Q2FwMEjDSQ8721VA5ysuGNqO/v65J+1WCQOQLlXR
	HyctHc3dQXIGHtcslZUQKsEJtaxHvQMwVomA==
X-Google-Smtp-Source: AGHT+IFjKArWkw1DSxq8VyVfr3BAgiXDtfD7+MsJ0RaIGRQ1j4scrOis/SC3f5RBEf1d1A5CQWt8Rw==
X-Received: by 2002:a05:600c:8b4b:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-4778fe50df1mr117952345e9.2.1763395543365;
        Mon, 17 Nov 2025 08:05:43 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7408:290d:f7fc:41bd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47796a8a695sm152861485e9.13.2025.11.17.08.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 08:05:42 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,
  <netdev@vger.kernel.org>,  Simon Horman <horms@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Jesper Dangaard Brouer <hawk@kernel.org>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,
  <bpf@vger.kernel.org>,  Nimrod Oren <noren@nvidia.com>
Subject: Re: [PATCH net-next 1/3] tools: ynl: cli: Add --list-attrs option
 to show operation attributes
In-Reply-To: <20251116192845.1693119-2-gal@nvidia.com>
Date: Mon, 17 Nov 2025 15:56:17 +0000
Message-ID: <m2seecmz4u.fsf@gmail.com>
References: <20251116192845.1693119-1-gal@nvidia.com>
	<20251116192845.1693119-2-gal@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gal Pressman <gal@nvidia.com> writes:

> Add a --list-attrs option to the YNL CLI that displays information about
> netlink operations, including request and reply attributes.
> This eliminates the need to manually inspect YAML spec files to
> determine the JSON structure required for operations, or understand the
> structure of the reply.

Thanks for the contribution, it's been on my wishlist for a while.

[...]

> +    def print_attr_list(attr_names, attr_set):
> +        """Print a list of attributes with their types and documentation."""
> +        for attr_name in attr_names:
> +            if attr_name in attr_set.attrs:
> +                attr = attr_set.attrs[attr_name]
> +                attr_info = f'  - {attr_name}: {attr.type}'
> +                if 'enum' in attr.yaml:
> +                    attr_info += f" (enum: {attr.yaml['enum']})"
> +                if attr.yaml.get('doc'):
> +                    doc_text = textwrap.indent(attr.yaml['doc'], '    ')
> +                    attr_info += f"\n{doc_text}"
> +                print(attr_info)
> +            else:
> +                print(f'  - {attr_name}')

Does this line execute? I think this scenario indicates a malformed
spec that would fail codegen.

> +    def print_mode_attrs(mode, mode_spec, attr_set, print_request=True):
> +        """Print a given mode (do/dump/event/notify)."""
> +        mode_title = mode.capitalize()
> +
> +        if print_request and 'request' in mode_spec and 'attributes' in mode_spec['request']:
> +            print(f'\n{mode_title} request attributes:')
> +            print_attr_list(mode_spec['request']['attributes'], attr_set)
> +
> +        if 'reply' in mode_spec and 'attributes' in mode_spec['reply']:
> +            print(f'\n{mode_title} reply attributes:')
> +            print_attr_list(mode_spec['reply']['attributes'], attr_set)
> +
> +        if 'attributes' in mode_spec:
> +            print(f'\n{mode_title} attributes:')
> +            print_attr_list(mode_spec['attributes'], attr_set)
> +
> +        if 'mcgrp' in mode_spec:
> +                print(f"Multicast group: {op.yaml['mcgrp']}")
> +
>      if args.list_ops:
>          for op_name, op in ynl.ops.items():
>              print(op_name, " [", ", ".join(op.modes), "]")
> @@ -135,6 +172,24 @@ def main():
>          for op_name, op in ynl.msgs.items():
>              print(op_name, " [", ", ".join(op.modes), "]")
>  
> +    if args.list_attrs:
> +        op = ynl.msgs.get(args.list_attrs)
> +        if not op:
> +            print(f'Operation {args.list_attrs} not found')
> +            exit(1)
> +
> +        print(f'Operation: {op.name}')
> +
> +        for mode in ['do', 'dump', 'event']:
> +            if mode in op.yaml:
> +                print_mode_attrs(mode, op.yaml[mode], op.attr_set, True)
> +
> +        if 'notify' in op.yaml:
> +            mode_spec = op.yaml['notify']
> +            ref_spec = ynl.msgs.get(mode_spec).yaml.get('do')
> +            if ref_spec:
> +                print_mode_attrs(mode, ref_spec, op.attr_set, False)

I guess mode is set to 'event' after the for loop. I'd prefer to not
see it used outside the loop, and just use literal 'event' here.

> +
>      try:
>          if args.do:
>              reply = ynl.do(args.do, attrs, args.flags)

