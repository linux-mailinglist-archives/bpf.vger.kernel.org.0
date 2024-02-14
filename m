Return-Path: <bpf+bounces-21927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC4C8540C3
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 01:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BCF28E357
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 00:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B04533DD;
	Wed, 14 Feb 2024 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh3iwos1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851E52CA5
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869802; cv=none; b=UXe1TES6mcG2TnJtA/3DbagdLk8UuoL0yImVPt7UqVDvFR0vZec5RS4K6mnev/WwAoUOcLfDe2+yoZkN8r5ZA+m3Kv07w89W1uMQQdcNHB3BSpaDm2fAfM6hY7StIAEqx4DoTJl0zp0B3FWrQ1IogbnjbmdO9Ki9O7gxLiaIjaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869802; c=relaxed/simple;
	bh=x83oaEGfY6XUdfnCvqHHviv6QlVDgBe3k3FbFciVrKY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tFHl7ffyz17KI+JL9CdKoLZHmZ235hNaPpVUHLwxmCJOdJoA5idByBOoTCV6qsIdGn8D4oXiwvFn0tcDyipuPU+oDUQe+yEVoO+JYe1LqrOqBwrVsA65X9nrQifRG3iRguVJo/rDZlyHF4eZozQ3inn2TzXgaX61NWKdLg9PLYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bh3iwos1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3cede53710so168371266b.2
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 16:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707869799; x=1708474599; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x83oaEGfY6XUdfnCvqHHviv6QlVDgBe3k3FbFciVrKY=;
        b=Bh3iwos1NoX9yK5R0zGhEjSRmkCYEl3eugx7Xl3AIzxoeQc17NfYEfAfs+pweu4ADn
         +5hOMTDNWqD6fJMrWxrl/n7hd/h7F6zXyl/b8y5mEwP2L+Y3bWB+LHS1tIuEWhxbx7zZ
         JKLOTv3DoxZngLXCFwxIVoS4ZuTn1AHW9h/QOFbBqet5aBeHGE8/tRbsA/UTMYMHR/4E
         F3cp95fO1mYhGRRlz0DL16yFe2XomkhfFd+9v22lOfsSv8trm2uGHAfOg6HRD3U370B5
         qfHo7pi0HcLVS2f2wv9GovcD86b1SvoZjbkmHsPLmG7IvhyIFk5X/5enV5q161Tugkbz
         01ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707869799; x=1708474599;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x83oaEGfY6XUdfnCvqHHviv6QlVDgBe3k3FbFciVrKY=;
        b=OFwC5aWHCETFx0aIONQOLlBy5ZA7AgJFO+hQ3JorZm7bIjBh4bZostD2eLB8WzvX3q
         /6c/EEONVl912haUeQJqEHpda4VKBZwxnGw4Ss5/vTg+DbHbUGgM/LM0N7hJEZ5+TR0F
         uEbEAofJf7jVqOGzDW/9lsLkpK8PBlMPmsaMVRxgga7oi8t3ydUKE/NDcbyAJMDTYN4e
         dnRPT6wWvuSD9H4UBGcoJCkhAJcUDr7DMrzaZV3hbZ1L1PUlGXPGGbSJhmxU5+D8nHfr
         FXjnqfOrWFKZj4HeW7t3Pue7rqDBiwmFFG3XiaM69WLYDHBvgkU4dujrTsloXSHa85zr
         zNzw==
X-Forwarded-Encrypted: i=1; AJvYcCW5/T0XJbwTpgfe1lFJ7zJXd10Hehtaoqd9Yx+VGGxDanXpfqaGZMxDmAaBubu7buw8mx2gSQYk3pVmZyubTITzfxs4
X-Gm-Message-State: AOJu0YxNJqjd10nKu0zBU91H6yfi3S8xUkv3sDiINYwKKjhTRmkjoEIT
	XtKDRH+u31og8KqPjZxetsf1a0iqgh7vPufMnbEcdyAJEL4lRPkC
X-Google-Smtp-Source: AGHT+IE/MNFDlk4yHlNN97dJ56ckM4TRb3UBCOdX9dzdirIj45GLTyrgeNrAfQK1w+z067gxX3MqBw==
X-Received: by 2002:a17:906:f14d:b0:a3d:2762:71f5 with SMTP id gw13-20020a170906f14d00b00a3d276271f5mr578144ejb.28.1707869798537;
        Tue, 13 Feb 2024 16:16:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCUt2ZEZDyR/gJdG7VPNXaOm0ZF93EKLbxd7Tj2BJZBbmtw4+AH2e8ahwd1MMPbSosSd02fXNUO4r6x2zgAcjqRRh5IeRbh6xTmsMJx+PC7G/yM73JJG85HuXB1/w80Ix3uJJRm/XCdsUsZ+2LlJAtxkOlfM/mgq009fW9pMI0GIuDVF5JfW6riakxuv3XIE2GM0HfBpM6kfyJ2Thpcqt1nlxjai0RDxa+POqUDkKNdrZghQOe73gPuoYflykw8NXPCFHbFAH1NWq3n+mdm9HbsgDdnjfyhzP3ojS23Hu+Q0s5ignY3HyAsD+biDdnywtntvagRhT0/XsWfx0jFZzT/um9ELNU7g4Cx9tC2fX7HkC9+D4TbjD5jBPVeOIrr67xDVXpU+TfKDp2PvsCMA==
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ty8-20020a170907c70800b00a3d09d09e90sm996537ejc.59.2024.02.13.16.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 16:16:38 -0800 (PST)
Message-ID: <978e656fb27850b002194f0cfdbe603997ef70e1.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 14/20] libbpf: Recognize __arena global
 varaibles.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, 
 daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com, tj@kernel.org, 
 brho@google.com, hannes@cmpxchg.org, lstoakes@gmail.com,
 akpm@linux-foundation.org,  urezki@gmail.com, hch@infradead.org,
 linux-mm@kvack.org, kernel-team@fb.com
Date: Wed, 14 Feb 2024 02:16:36 +0200
In-Reply-To: <CAEf4BzZyPDdtV8xyFxpLmPQpKrtO-affGrEfyDkodr_BDHVZcA@mail.gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
	 <20240209040608.98927-15-alexei.starovoitov@gmail.com>
	 <e9fbe163f0273448142ba70b2cf8a13b6cca57ad.camel@gmail.com>
	 <CAEf4BzYbkqhrPCY1RfyHHY1nq-fmpxP2O-n0gMzWoDFe4Msofw@mail.gmail.com>
	 <7af0d2e0cc168eb8f57be0fe185d7fa9caf87824.camel@gmail.com>
	 <CAEf4BzZyPDdtV8xyFxpLmPQpKrtO-affGrEfyDkodr_BDHVZcA@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-13 at 16:09 -0800, Andrii Nakryiko wrote:
[...]

> The "fake" bpf_map for __arena_internal is user-visible and requires
> autocreate=3Dfalse tricks, etc. I feel like it's a worse tradeoff from a
> user API perspective than a few extra ARENA-specific internal checks
> (which we already have a few anyways, ARENA is not completely
> transparent internally anyways).

By user-visible you mean when doing "bpf_object__for_each_map()", right?
Shouldn't users ignore bpf_map__is_internal() maps?
But I agree that having one map might be a bit cleaner.

