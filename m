Return-Path: <bpf+bounces-69254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61AEB92700
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 19:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D0A443A71
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 17:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14DC314A76;
	Mon, 22 Sep 2025 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qf9mbYni"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DB728312D
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758562281; cv=none; b=PmivkmYbystQ345187PFMaKCekoO5onHVas82fAy1/X8FPMpgqjPfds083jt5YSn6xfTZiHI1J3RTchpxfDqPGl1cOulA+WXVpZjVUrMWol/Iu50Sif2cpLQpy5WjEzYZTNEA/sU9oIU/RneyjU7uhnLQRpeM4KAi7DFnPFXtSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758562281; c=relaxed/simple;
	bh=KBs3xs0STiB+jtaoREDLZQMrlMBs6QHNmXIFgpQw1SI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txD5XUkvPmllm1b5s8kCHOtuPVVbHHTD7KzRRJvWdABL3uNoKdfNPKYnqgRxCdllSSvtCArRKppUicUMzJ8EOT299vi9WrinOepvtzc+JLc00OBttXzc6QOIGbJNwHYA+Sc6jDLx4VaHqAXS2Pf3Him3QKW/6bYR+P4WrzXyezQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qf9mbYni; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e1cc6299cso669235e9.1
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 10:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758562277; x=1759167077; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=57hHshaXKLHOibww84RQI+56Vz134WQnlwZkNd7v6oI=;
        b=Qf9mbYniFiJAJezjN7HTcRHJ9Qy7M1i/K4looyj7PDPplZgeJbgZpeBWj1ESeZdcmV
         1AWWqB3SrJq/K35JJSQHhHyn9hXgbDde7YfrSJ2CxECytna4SCwVcKoxqqHR6hRa/9V7
         SOTur+lQEJ9A9vZUeE3sx125N1ZCYh6jUjqhyesQiLRpvYAqjW4P5GrkoeG59LrQ8/7e
         9BqkQ2LETuYI0znaUI2mZAcToMecl1cFR7XKMHhDtop0C8OYAS9pMeNldMBCiHNjdJSS
         8NLb5CIbqsBAjwxSSkRIMAc8t6jhQ+eYnZ95ADbFgvdxSIWlsapmKD+7zrtv/DwSxXQj
         b5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758562277; x=1759167077;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57hHshaXKLHOibww84RQI+56Vz134WQnlwZkNd7v6oI=;
        b=Fa+mEgsPNNmfB5eK7Jf96n3Sa5GkO8N90xt1n4c/On+nst1y7iNJAYFffJ9aotX3Fz
         UBVWViuybTrA8Cvv4kzPxxgMlXpy6/XaMipSbrV0lsdV09lOhAi9qOHTTerD73bEqk8h
         Sq16HPT+ZpGxNQCISZf78qyqTXIjeQPyKlY1gGqzaQ7GDvO/yuvTnzja8TdKnAORpBE4
         kgwFEzABF1fTx7bs+NcfVftwIToPV62D9frv4lswYnBHRkbbjfSqUqgCgb9goxvHMn4t
         d5ePoxLXHnH5cbZROC2Ep6Wo0oswJcP7I4Visu5QnSvE5VuQnE6ZHIRbcg3ZP8/+vJuT
         ZQWg==
X-Gm-Message-State: AOJu0YyPCP+LAKwdTG13mkpFIqjvEsywWzmAlLkjn4JrHtVhKs8GF6y7
	c6wEJ0uxW44YEIUem0IHDNiqpf83Aef3rbvgOdnSPLW0jItc7X5DPasu
X-Gm-Gg: ASbGnctO27ceEIovdC2K8g4KtmVaFsRONK/bJjE5Ej68zW2BvsulUJt8/d1L/EfSQNq
	E1w+jdTJXolKoYr9fSooo/Vfl+5k4xkygwy3uU/RATGbLfvogG8j5xVXaGjPoJqjHaXYu2L6ncD
	A7ddRai3FR0/UqR/niOJPnUa4zg0bxrRg6X5FvEecfNq8DV+zgwm/3fNyRTS+sVFLOlPbmLMcfn
	hXnnl6U5m4HhGOMBzxqX6+wdzkyZml7VGINxtCIqG5dZruw/D9Lq/r1TGStNIC8FPgxUoxcRSp5
	DA1xrccvGRJ+n3SpTQlyQ0nNKyj+J5qoDyUESzOZsNmy1hC7NWLh/XCXQzn9jAYA/csfEthpoko
	m4XUctqPXrPs+2jaMYWq9MBNkkk4KMFKF
X-Google-Smtp-Source: AGHT+IG+2vpgK7pe6wB1gNYSWry2Y2XfEGzaI4Y8KDfyBwcSF/AsABsmg4wLQga6pMg807VPh+YbTw==
X-Received: by 2002:a05:600c:45cd:b0:45d:7d88:edcd with SMTP id 5b1f17b1804b1-467eb23112bmr135623905e9.30.1758562277180;
        Mon, 22 Sep 2025 10:31:17 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464eadd7e11sm221277335e9.0.2025.09.22.10.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 10:31:16 -0700 (PDT)
Date: Mon, 22 Sep 2025 17:37:19 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v2 bpf-next 03/13] bpf, x86: add new map type:
 instructions array
Message-ID: <aNGJT6IosAI7HP+B@mail.gmail.com>
References: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
 <20250913193922.1910480-4-a.s.protopopov@gmail.com>
 <CAADnVQJsuxh5HrNKW_-_yuO5FqLQ8S4A4YN9bZfRHhO5pt5Dtg@mail.gmail.com>
 <aNEnLZzOyEuNOtXu@mail.gmail.com>
 <CAADnVQKK80Vvph7W7PSwG_GAPwXZO_wNYOKt6h9LHjHhPcjHPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKK80Vvph7W7PSwG_GAPwXZO_wNYOKt6h9LHjHhPcjHPA@mail.gmail.com>

On 25/09/22 09:16AM, Alexei Starovoitov wrote:
> On Mon, Sep 22, 2025 at 3:32 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> > > > +int bpf_insn_array_init(struct bpf_map *map, const struct bpf_prog *prog)
> > > > +{
> > > > +       struct bpf_insn_array *insn_array = cast_insn_array(map);
> > > > +       int i;
> > > > +
> > > > +       if (!valid_offsets(insn_array, prog))
> > > > +               return -EINVAL;
> > > > +
> > > > +       /*
> > > > +        * There can be only one program using the map
> > > > +        */
> > > > +       mutex_lock(&insn_array->state_mutex);
> > > > +       if (insn_array->state != INSN_ARRAY_STATE_FREE) {
> > > > +               mutex_unlock(&insn_array->state_mutex);
> > > > +               return -EBUSY;
> > > > +       }
> > > > +       insn_array->state = INSN_ARRAY_STATE_INIT;
> > > > +       mutex_unlock(&insn_array->state_mutex);
> > >
> > > only verifier calls this helpers, no?
> > > Why all the mutexes here and below ?
> > > All the mutexes is a big red flag to me.
> > > Will stop any further comments here.
> >
> > Mutex came here from the future patch for static keys.
> > I will see how to rewrite this with just an atomic state.
> 
> I don't follow. Who will be calling them other than the verifier?
> Some kfunc? I couldn't find that in the patch set.
> If so, add synchronization logic in the patch set that
> actually needs it. This one doesn't not. So don't add
> any mutex or atomics here.

The usage of this map is as follows:

  1. A user creates it and fills in the values using the map_update_element (syscall)
  2. Then the program is loaded

The map <-> program is 1:1 relation, so I want to prevent users from

  1. Updating the map after the program started loading
  2. Allowing two programs to use the same map (while, say, loading simultaneously)

At the same time I want map to be reusable for the same program for the case
when the program failed to load and is reloaded with the log buffer.
So there should be some synchronisation mechanism.

(In future patchset, the bpf(STATIC_KEY_UPDATE) syscall needs to execute. It
needs to be sure that the map was successfully loaded with the program. But
you're right that this doesn't make sense to leak part of this patch into this
patchset.)

Does this make sense?

