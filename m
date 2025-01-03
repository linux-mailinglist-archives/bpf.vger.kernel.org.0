Return-Path: <bpf+bounces-47829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFDAA006ED
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 10:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAA63A3FDA
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 09:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F2F1D0E28;
	Fri,  3 Jan 2025 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRudzvSB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C102B1CC881;
	Fri,  3 Jan 2025 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735896476; cv=none; b=LmYUxu5/DkNntiL01CKVBxA1bgh+9iA9js6+p66Pds7YcOGSARiluerAy9dlIPnw7CDfflZt3P/ofBP08cKaiG0Uth0WMsyCTF4d+gyrEA+Fkyh1KMmuMUi7IciJ5kuH/y1/w3O4y7ogVLPCbbfQMafjGV/tGbpWkBASpISo2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735896476; c=relaxed/simple;
	bh=pbyKroZ1THqSN4mSzl1wEDOWGyG14MvxvjKeCqPPRaE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXM8G2KPSaKdCvMBlTVVb6CfBCagEKIiwurcrGOpcTkP/uK0hohQaC10/YplDGnpKcfM9OKDLLYj0+wT7hkaHjQhJKuYkSTy5RYjhmz7JhXW2Xa3L2dDwntO6PReMRGY5kjG1utkAXNP2KYwb6wjeZBD2fYRgiGoSMQSEwz16bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRudzvSB; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaec111762bso1810995666b.2;
        Fri, 03 Jan 2025 01:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735896473; x=1736501273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ofpBHthkGihWAJRtUQ0O1LsJMkxxVeTnAwO7vMuK5I4=;
        b=ZRudzvSBaCaWXkzeq3MkR34z0hP5nDd090CaTC4DLZi8chIsVgYUaOnEXFb6+r4kUB
         jhlozvPTyV7Gumr4D1AgENtR+ZY0yt8v+VSMqw5WbRByyljIzpCm8MXroDk8u81uvPvf
         ymK05vLcxGN9ZFNkTrNspUnFe8rjVeV/dB2QSfY7hk8KFfhbea4neP186GgSSPILAOUC
         blKKixIbd2idmcMxvkP/51cnA9jhWvqiLFzVPi1uSHgzgvNvf+mhvNkB2UqA/HDdcE+n
         uKvZl/USD9dcCDLo12WcMRivyzxsxNSustiX+Me/U5VY2T/+11smEEcVR69IhDMkJ25J
         kD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735896473; x=1736501273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofpBHthkGihWAJRtUQ0O1LsJMkxxVeTnAwO7vMuK5I4=;
        b=cxnwFTwyXWMaX81M1wixOQMs1onzFOy5Hx3juMP7BBqOGWNe1J2nXy6c+6wY0/nuIr
         Lg0GcDFXayvT7UaLfZrBBziiAFAj2HL/vIHWuz74BXAZ7PtU58GPaGxhM1hbVZAkkm9x
         j9J4eK208S1ut8WEpFMnfZH+hx1wDWicL9mDx9KNlCebq1TEdVj/LBHoUqDOpkd9RBCg
         7t1aFuzSvOFsT3YvfH7xER5dZ+Y2SsXKxmdUpJO08appVWs9JpvBnRGYHFvdVLwGzMrz
         I9ww8ancrFhNJSUwas2ehP4+glCLCEuqpy7yOP5j1HykNuhhG3BhUBIjnGDPV0b/W1Se
         V36Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRFkXsjUn5EtJA7TVldtUtg7Tmv5SBU02dduTnc4oQwB2H4o23NUVrnVy074H8o4M71IA=@vger.kernel.org, AJvYcCWZzBT0TGSuX5lpP5UYKXtwI2/O1a9suEbDPAjYs3ClMtLorzZxdNXzypONrazgShAmR/gYgwjhWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfsWLl07MSRKe6U+UnDLtUac7Xis0g+Isxcyye2kJzjy6ddQKb
	AUSbZfbNLah2eiiIyCueKgw4fbaIZcXGmELBs/hFVEzc2vXRkP56
X-Gm-Gg: ASbGncs4wlFX00JRWC9pb/p2ceNw1vLtGmAg++Zj4eceHBX/Ii+55Sa72xyE0g5XYgY
	KdRrOM7CmjCmp0IrXBzxrmAuNgCvZWf94ttvV/idZ/cDW+hyp9bJIhEJZzoiDG0yYl0GUOXM8Jr
	o8N+qhfxQkPQ5EgmhXeiRu3ztyqCU5km7KHgDj+4zizTEkpbaLL3Jq7YHSS3M0pHFQPoESUrjpD
	jvQ6KRsRrcLQrC3wePWUOhz2UO4guG5216lzsJdAXM=
X-Google-Smtp-Source: AGHT+IH/HCA3rrUj/f+XHB3lRr55JkVr70iXl4gQPy+fPRyDJeNfylEreUcAE2wukCOHb0mKe5NISQ==
X-Received: by 2002:a17:907:2ce6:b0:aae:c9bf:41b3 with SMTP id a640c23a62f3a-aaec9bf461emr2890554366b.37.1735896472766;
        Fri, 03 Jan 2025 01:27:52 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f015270sm1858303266b.162.2025.01.03.01.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 01:27:52 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 3 Jan 2025 10:27:50 +0100
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Jiri Olsa <olsajiri@gmail.com>, dwarves@vger.kernel.org,
	acme@kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com,
	andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v3 8/8] btf_encoder: clean up global encoders list
Message-ID: <Z3etlqj0h8rG88IR@krava>
References: <20241221012245.243845-1-ihor.solodrai@pm.me>
 <20241221012245.243845-9-ihor.solodrai@pm.me>
 <Z3VzuN8yX63qktPl@krava>
 <hG-genPmZbX2hjVJ0oU90oOYrm7AWp9v0_G4kJwRvC3TBbFcg1rPFMEfu4-zQT8YHDihSU4XbSYNru8XrS-0fcpwSos0AODh8ASitiI5szQ=@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hG-genPmZbX2hjVJ0oU90oOYrm7AWp9v0_G4kJwRvC3TBbFcg1rPFMEfu4-zQT8YHDihSU4XbSYNru8XrS-0fcpwSos0AODh8ASitiI5szQ=@pm.me>

On Fri, Jan 03, 2025 at 12:43:42AM +0000, Ihor Solodrai wrote:
> On Wednesday, January 1st, 2025 at 8:56 AM, Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > 
> > On Sat, Dec 21, 2024 at 01:23:45AM +0000, Ihor Solodrai wrote:
> > 
> > SNIP
> > 
> > > -static int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_proto)
> > > +static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_encoding_inconsistent_proto)
> > > {
> > > struct btf_encoder_func_state **saved_fns, *s;
> > > - struct btf_encoder *e = NULL;
> > > - int i = 0, j, nr_saved_fns = 0;
> > > + int err = 0, i = 0, j, nr_saved_fns = 0;
> > > 
> > > - /* Retrieve function states from each encoder, combine them
> > > + /* Retrieve function states from the encoder, combine them
> > > * and sort by name, addr.
> > > */
> > > - btf_encoders__for_each_encoder(e) {
> > > - list_for_each_entry(s, &e->func_states, node)
> > > - nr_saved_fns++;
> > > + list_for_each_entry(s, &encoder->func_states, node) {
> > > + nr_saved_fns++;
> > > }
> > > 
> > > if (nr_saved_fns == 0)
> > > - return 0;
> > > + goto out;
> > > 
> > > saved_fns = calloc(nr_saved_fns, sizeof(*saved_fns));
> > > - btf_encoders__for_each_encoder(e) {
> > > - list_for_each_entry(s, &e->func_states, node)
> > > - saved_fns[i++] = s;
> > > + if (!saved_fns) {
> > > + err = -ENOMEM;
> > > + goto out;
> > > + }
> > > +
> > > + list_for_each_entry(s, &encoder->func_states, node) {
> > > + saved_fns[i++] = s;
> > > }
> > > qsort(saved_fns, nr_saved_fns, sizeof(*saved_fns), saved_functions_cmp);
> > > 
> > > @@ -1377,11 +1313,10 @@ static int btf_encoder__add_saved_funcs(bool skip_encoding_inconsistent_proto)
> > > 
> > > /* Now that we are done with function states, free them. */
> > > free(saved_fns);
> > > - btf_encoders__for_each_encoder(e) {
> > > - btf_encoder__delete_saved_funcs(e);
> > > - }
> > > + btf_encoder__delete_saved_funcs(encoder);
> > 
> > 
> > is this call necessary? there's btf_encoder__delete call right after
> > same for elf_functions_list__clear in btf_encoder__encode
> 
> At this point we know that the function information is no longer
> needed, so we can free up some memory.
> 
> I remember when I wrote a "context" patch [1] (now discarded), there
> was a significant difference in MAX RSS between freeing this right
> away and delaying until encoding is finished. Now it might not be as
> significant, but still there is no reason to keep the stuff we know is
> not used later.

ok, makes sense

jirka

> 
> [1] https://lore.kernel.org/dwarves/20241213223641.564002-8-ihor.solodrai@pm.me/
> 
> > 
> > thanks,
> > jirka
> > 
> > > - return 0;
> > > +out:
> > > + return err;
> > > }
> > 
> > 
> > SNIP
> 

