Return-Path: <bpf+bounces-70135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F10BB1916
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 21:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 985C819452D0
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 19:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA152D7DF8;
	Wed,  1 Oct 2025 19:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIpg1VcS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484D0257AC2
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759345626; cv=none; b=XZf5rokL7gWmFeD6Ta6WaDFruCOS3o7dI3f1GY40+V8l2v6QEWqcQQyXzHqO3Wy0yI6dUZEuT5XI9Ln3pspR9cwFFGJKl6GRQDbvcq8gmvRBJZTX6WTULT+m06QMiKgoVlbi6VRzFKnuwuqtZGcF8nA4yyTa7J/83nDCY/+Mqfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759345626; c=relaxed/simple;
	bh=cWzgcCoPSauYvlrSVFZM3cx2SHdHfppB5pOxWNXwB8k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e5u9CCmBjaSXWVMa3fA6eKjglQsyvVyio7/msWJhn1+noVwTZeetyuZfvBuIvjUW4lBIAvAPVrgiG0kUgkuro/iiQso0GqMZ9ulU4LniDtUQTLxsuORKEMwp7dvCkEAIAepAgXH2AvCOX60p0PV8AAVWej0KPlsnZXGbJimH7JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIpg1VcS; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77e6495c999so291319b3a.3
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 12:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759345624; x=1759950424; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cWzgcCoPSauYvlrSVFZM3cx2SHdHfppB5pOxWNXwB8k=;
        b=DIpg1VcSWHGoq4WY45pLS9Zgy0wtkujxbhGE3bjW43ndml1XrV6u8PyAINhhUeF+ZE
         VWsIIY6dinQvOVy+P+KCToiueGliH5b3CobugyV7MbRulwqFHFXNrmJHNpYY+kXGhdNI
         4DkDDnkhNZ3+BT+WyLgHZ8aHxGxP4Dwt54Vjs8czhVrJlwI1I0oN0KLqVqWVVUEA/qzU
         XOEUw1DP84MpPt7x93tzJevzkB8byzNZIgl29fHukE8QMrgt0AlsEXIfkROIZAr/I76Q
         uWF5+v01N9Xh7cgtGlZ6n5shq0jWQY+3K4vZdDmpUDa2Qb0BnQ7rUQ+l2Az7V4N5qJbW
         XByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759345624; x=1759950424;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cWzgcCoPSauYvlrSVFZM3cx2SHdHfppB5pOxWNXwB8k=;
        b=CSumkSJko9s7irZKePhvvdKOFXch7JrB8lZo3PEODwC8UZ7N8DKAtM++nl+1Uz0GjD
         ROp6esn+OXMuBTxY20ik1BpqKteWobeu6hDHICxevX+oWCMVQ6NZ4N2SRNHQCVv2pxvP
         VhYGsGB+auCRiNJbjpAJTEUiIf8WZdTrh7+v8OVS9ATjwX9HYldq48w+cmixQ4wspzf3
         3nYqy+ny8aa9SYRex8JcyWzlpH4s0uuUZbESLtGJxZpjyqj/ejFAGJrRUrrot/q0Vbsb
         WaZbQcC2zYqWCFaBM5bO59+RL+VWZ+r4F+C1qS+7bSdoQUf5N6Fn1S7qi3kZQ67BpiaH
         IS6A==
X-Gm-Message-State: AOJu0YyfXbmWKP1niFZJoqrn4/nw7nFp9kReKMrR8ziMgnnnIRtapFBY
	luXFmWkVcXaxBF+zSqEaeVWYgHGBEBvj/uB52rJdhunVAtzuvcDvhYMLBI5KHWD3
X-Gm-Gg: ASbGncvrU+NiNDlKQjKvhqKLFIgKrFYHfI/X9X336geqhYi6E4Nsv19hazBC1iPUeqy
	4CNs8QTL75+WUiSIXsUiyE8YOoI1Fcq3WMXhDJfFVa3FNG+d305C7D2Jbdlt71J3UNaTedyxo+D
	7wlN1x11/5GD5oFhaO7yAmY+tfei5qGUTRE9cP8fTEddgv6JkHBB3DvDDPCJtE8uw3uii2DENw4
	/U++1LRjbof1hwtjdF5jxV/Y4/G6UZNErFy0iSkCGj2jAF6WE54EDJQWlaNSU0120oF6W2YpVVZ
	b02FNUlaD4bl7OTMY17RN73TbJGbo4FBpMNgsCcd0CHk/dNBMXak4m5Mq4d9Fi8GswCH90CQHp4
	LoZHeQBwJ0oVpE9+XWvbCVvgWI/nHKVELaW6EcJxAAK2lA0+y8tzmHZcfGDrfziGtY8x4r2w=
X-Google-Smtp-Source: AGHT+IE+tPUSUJXvF7R2zGAFz4sl5pkxYGOFHzB23VN/vx2Ih2dXbqWNzrIuu7kYKwvcwTI4urKSNQ==
X-Received: by 2002:a05:6a00:c84:b0:781:2656:1d6b with SMTP id d2e1a72fcca58-78af4258e7fmr6103852b3a.24.1759345624645;
        Wed, 01 Oct 2025 12:07:04 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9dadbsm408748b3a.18.2025.10.01.12.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:07:04 -0700 (PDT)
Message-ID: <3f8925905d7e196b81a9b412a856578ed73c38dd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] bpf: extract internal structs helpers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Mykyta Yatsenko
	 <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	kafai@meta.com, kernel-team@meta.com, Mykyta
 Yatsenko <yatsenko@meta.com>
Date: Wed, 01 Oct 2025 12:07:03 -0700
In-Reply-To: <CAEf4BzbK9cY+Oqn265uyzKSBWjy6rFRwUheMwZBJUeeuGGDrhw@mail.gmail.com>
References: <20251001132252.385398-1-mykyta.yatsenko5@gmail.com>
	 <20251001132252.385398-2-mykyta.yatsenko5@gmail.com>
	 <CAEf4BzbK9cY+Oqn265uyzKSBWjy6rFRwUheMwZBJUeeuGGDrhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-01 at 10:00 -0700, Andrii Nakryiko wrote:

[...]

> > +void bpf_map_free_internal_structs(struct bpf_map *map, void *obj)
>=20
> I'd try to make it clearer that we are working with map value, so obj
> -> val, and maybe name this bpf_map_value_free_internal_structs
>=20
> (though we probably want to come up with shorter name for this
> concept, "internal_structs" is quite verbose, but I don't have a great
> suggestion)

bpf_map_free_value_fields ?

Otherwise, nothing to add to Andrii's review,
thank you for working on this follow-up.

[...]

