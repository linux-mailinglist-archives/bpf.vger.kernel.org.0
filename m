Return-Path: <bpf+bounces-30061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 664B98CA52D
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897F91C21063
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 23:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C27750A63;
	Mon, 20 May 2024 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AoUu0/+i"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6190C36AFE
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716248641; cv=none; b=po1JmMqh+cLjur31/K3+1IEP5Zeynxdhkye1JRGPHYlFKGDT9zIbCePgfvHFSx16YIiMlFotATBaAZa7h6kL3oQKiDcfhmciBjPOWsvPkFG8ZG/m/vpREIULFS4ZaL1lvtRs1+p+d2qbaCcseAKbwW3dYYx48ZHPhMbW5+5X5Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716248641; c=relaxed/simple;
	bh=5QrugeDcRbTRQ+9ifBVvmLCQp+vK8vcrw3Zl9br8X+g=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=BYevG78rgCLi68p+v32H4K5pOAFokqwmC0/W8k48k7a1yh+dJoumVhjZdHioQ1p3pU+oJ546wBQoeI/HP0KOeXs7CrmwbQLmgwZI/Zj/qGcKi4T3TiQncvQ48updz9IRKokog2Bu3pIzIDiBLd857Z7a1VDBhRuBFZIEDNnTK7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=AoUu0/+i; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1eeabda8590so86110555ad.0
        for <bpf@vger.kernel.org>; Mon, 20 May 2024 16:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1716248639; x=1716853439; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CiGU66ticLbjDoYRbCThnU9FDJrB3guBcEjgVyBFEvA=;
        b=AoUu0/+iEmCJ7SLbBrOdDqmBWwwz/MT5Zg/uKFEpx9gV4t7s5/8nmYvaTO5hFLF8KQ
         zrXB6ZSh5MmLiMAKdhmY+xO8DMm9t2E/kzWP/2uyIzaxEnVevySYDtGgQ/NPvZim7M2a
         eDXrxQD0vX6b5eT0vKeW97piC4ZX89+THLJBUBxmqjlxElelimgfKeibL7tM+rUjTGJs
         4EwArAmdRuZQJ0hK+puB4bx9DqnvcXZX1gmSq160KPFD1UO7X++R55wdIFYiXEf1wR28
         IH5XnnZpCc9ufLE1bhiHmZzYrMqCG4mKQqkaNHdNCffQDT2bCptpjZAT/0jSx51ni+gB
         jq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716248639; x=1716853439;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CiGU66ticLbjDoYRbCThnU9FDJrB3guBcEjgVyBFEvA=;
        b=ACmeDDTVWTG2q+yZz72LZXaCe1AY2uLGp4IZ0zLwAJ/OFGElfHDGRTjtHQWXxRhxi7
         GW1NfGyNUaH9Yd4PvlbmXmyRF+ahHFBvj0bGVOc1zulptmNbUyQFXpj+tTDPK3NsvS2T
         4kO3PMFcXihzSN2OaBzXyLwd66LpsiSXx801JxpmAIT78m8lck2yHo1S7a6dFgAj2HFS
         DvF27Fcv0UUGekBLoIMUyoEpeErVMaCO6pi313+6VfiOpwcpVEXFk+tfRM7oQR8thidz
         dWpHx6U477DeerGy0AiLepwAHp6D9pdAZ3DAEB7Kh46tSG60dWDqGhAGe3TciD+tA4Vr
         FCTA==
X-Gm-Message-State: AOJu0YyfSTyEiE1DrC7KyyJoDS/sbM/KgV/0niOivaDtbfWBpke3O4Yb
	7T56CqaKaGTz9Xd6sm5sCooUXB/2Aia2ApwckL/nAVfLEkPavgXBt6KMz/nz
X-Google-Smtp-Source: AGHT+IEGLoYUoVxx2IRUa5wVUIQlnERcuWSCfkZQspz8l2OdgRBy6qcrlqV3FUwzRaIvDb8T+ICPkQ==
X-Received: by 2002:a05:6a20:1591:b0:1b0:194a:830c with SMTP id adf61e73a8af0-1b0194a8502mr18892516637.56.1716248639554;
        Mon, 20 May 2024 16:43:59 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2aa01dasm20160764b3a.92.2024.05.20.16.43.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2024 16:43:59 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>,
	"'Dave Thaler'" <dthaler1968@googlemail.com>
Cc: <bpf@vger.kernel.org>,
	<bpf@ietf.org>
References: <20240517165855.4688-1-dthaler1968@gmail.com> <20240520231829.GC1116559@maniforge>
In-Reply-To: <20240520231829.GC1116559@maniforge>
Subject: RE: [PATCH bpf-next] bpf, docs: Use RFC 2119 language for ISA requirements
Date: Mon, 20 May 2024 16:43:56 -0700
Message-ID: <089c01daab0f$959a2fa0$c0ce8ee0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMNxtSz5Xxdo4l4z3k03OfsZBHpawMKs2HjryI7ZiA=
Content-Language: en-us



> -----Original Message-----
> From: David Vernet <void@manifault.com>
> Sent: Monday, May 20, 2024 4:18 PM
> To: Dave Thaler <dthaler1968@googlemail.com>
> Cc: bpf@vger.kernel.org; bpf@ietf.org; Dave Thaler <dthaler1968@gmail.com>
> Subject: Re: [PATCH bpf-next] bpf, docs: Use RFC 2119 language for ISA
> requirements
> 
> On Fri, May 17, 2024 at 09:58:55AM -0700, Dave Thaler wrote:
> > Per IETF convention and discussion at LSF/MM/BPF, use MUST etc.
> > keywords as requested by IETF Area Director review.  Also as
> > requested, indicate that documenting BTF is out of scope of this
> > document and will be covered by a separate IETF specification.
> >
> > Added paragraph about the terminology that is required IETF
> > boilerplate and must be worded exactly as such.
> >
> > Signed-off-by: Dave Thaler <dthaler1968@googlemail.com>
> 
> Acked-by: David Vernet <void@manifault.com>
> 
> We still have "may" in a couple of places, as in e.g.:
> 
> Note that there are two flavors of ``JA`` instructions. The ``JMP`` class
permits a
> 16-bit jump offset specified by the 'offset' field, whereas the ``JMP32``
class
> permits a 32-bit jump offset specified by the 'imm' field. A > 16-bit
conditional jump
> may be converted to a < 16-bit conditional jump plus a 32-bit
unconditional jump.
> 
> Also in the "Helper functions" and "Maps" sections.
> 
> Do we need to fix those as well? Or are they considered semantically
different
> than how RFC 2119 would define the terms?

Those are semantically different (i.e., I left them intentionally) as they
are not
normative statements about what an ISA implementer would choose to do or not
do, but rather informative statements to the reader that would be synonymous
with
"can" or "might" in my reading.

Dave
> 
> Thanks,
> David


