Return-Path: <bpf+bounces-59720-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE47ACEE23
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 12:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606083A1DBA
	for <lists+bpf@lfdr.de>; Thu,  5 Jun 2025 10:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17C6219319;
	Thu,  5 Jun 2025 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwU0m2b8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A3C3C17;
	Thu,  5 Jun 2025 10:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749120899; cv=none; b=EzSc34d4CaPGHTkmXAgb0+zeLIOvWC5XKiC9a8FrT50toIn61EudpiNMmAdL0phfKMcO0RJdjXJ5I51K3TLjyzmkMOWpc4Qr/Us0e3Up2ynfeZ0pMjK9NvkcJrCO2LFJiIcpNwTEWCkEi3C8/qqjceZrAqPJggY8zO8S74Rqtc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749120899; c=relaxed/simple;
	bh=qGJoIKuzWxeup+4EU8w+O1YM2vOcHJSSSMuoRwZiCQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvxFaUUclnw5osiUEtlz7Zz+Qo8QDdacAuKTg8UsspLjv+3pJQYDEJpxIVKnBK7LoYQMlh1kUNvhOGaqpsNzx5A6CsWVZGnYLFCFxtGXTsN9dSRRj9Km5aEydiac6cDXGDphLCT1b9J8L0OS81ftoVvrZN/DAasdBwuCYgQb02I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwU0m2b8; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad88105874aso135148966b.1;
        Thu, 05 Jun 2025 03:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749120896; x=1749725696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RVFpUO0Ly3idy9LjRRbGnnclNU17iOu62Gz5GozMQoM=;
        b=kwU0m2b8T3eAM1nmwOVMbIhZwLu4eGOUkJ2KEthWq+ucsMjmOaBrfQtRkdvVO4q/2q
         MIxKNP09r8TTAwDjO3n35x+ZnBFM4veESMJNfvutSnDxyQqYWGzJxQmsVwS3VgwUKOMR
         49mEvf5xhIB9uYY2FDgoLKCnbfTAqNQeomESo8VVfhVofv3lNcedyWOxfTcSDpvRlWO0
         dSmSLVzG4cVcYKQ5spG8a9JBRn1KN4Caf1/4GGZccUyoaJUKvcPGjc1SkI/ELcVh9nue
         za8nnoY9IY1nbSamQPVZzUJYc7ixCY8cUtSLkEsE3VjH6AMujUcJ0+/z3eDYPhXi0NlL
         YbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749120896; x=1749725696;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVFpUO0Ly3idy9LjRRbGnnclNU17iOu62Gz5GozMQoM=;
        b=e0T/jjIZA24eWL0nUA8K7doNlwnOdaQdSp3T2eFdNxWJxqDzs2JDI9rKUpmrBqZnRD
         rfjpPNmzWvTAYBu8zM5OF/zJ9zdH15J8jAl3LaoOEkkLyJ2Pl81dpzAACjXMOCznkKk9
         grItgyoP/+/A6AZjpQ7bAMRK3v8uPtrwwU0wLW/8o3hTxsYeTsBA1TzxWVTFM1RGzcYd
         b6zP+KzoTPfVl+LWCzuUN64BiRGIu/8a5WPE1Qd21tWeRlkQhwXQBoHcJOIZxyqZM7/K
         JFn0kn1VnCEH1mRgjrUw8yfMK4RJom/N9v2SlzHbcWkb3sOubULTIqb5y1zhnfLAGsPd
         pJwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhV5XgE/kgd2wjJSi5y8va6oVwoIBIBYn8QkbwiSZgUcPX0RXrwjFkLKrlTrK17tR0muKt//vVeSvwpw==@vger.kernel.org, AJvYcCWv3MWhHJE/pWpd9PqxHxVFmf0O8JU+clmmY9xRSyDzfrVfohlIu9j2WXwEID2vymymdPWNaVUQ@vger.kernel.org, AJvYcCX2xRjtdKfwE59iuH4nOTzqKgaE1kyHTJAuqbZFlqHYAPuBbamVqa9znqGhevGKL9ORz80=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbggZn5//66vwVNuadrtokcK62EfFnNqCCi4OB7EZVfhFIQZul
	tJ0sDMotJMAIUroWI1nTwjpM3T2iTd5/kPdm1eR1vD3ivHwxoyDY55uRIkWdi8rj
X-Gm-Gg: ASbGncuIsG82G7JzP15WfOoSXKwGRnshZqfUeVAXWCp+/+oj7n0CjEtWEXtk3hXxlvq
	3oUC+zxUQTWIYxDn12CbFSq2/3OFnDD6jTR9fdgiGTjMxVpM1yl85hHrF6AiAiQEVVwHOmj1F+l
	IP1qazhtN/db16xMyqbVCFG4rNzr22OUTobxqR71gL0xyqR6BUQsgTWsZAYnVbLK/foHme3MzzR
	BxOoooFztkzI5c4g+QHSEBtfr/tXeb3mtb9ANB4Yh22/yZmiJ6CuEbRyR8EtaeOoNn2r6lyoLk7
	QXySRqswtQSukFazDoymZzVmjpSeLgNz2INhQKmuhcXui3XuLFwJDlv20UU1ndGJ
X-Google-Smtp-Source: AGHT+IFOh3n0Lq1+0bCNr3K1c0pK3yMqrWaY4N48Q3In6bxJO12Nso8MJwVau6mL3MN8wVXf7QRWQg==
X-Received: by 2002:a17:907:3f99:b0:ad2:1a63:3ba4 with SMTP id a640c23a62f3a-addf8f5270dmr588304666b.37.1749120895954;
        Thu, 05 Jun 2025 03:54:55 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::22f? ([2620:10d:c092:600::1:d66f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adb390f09b9sm997635666b.75.2025.06.05.03.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:54:55 -0700 (PDT)
Message-ID: <390073b2-cc7f-4d31-a1c8-4149e884ce95@gmail.com>
Date: Thu, 5 Jun 2025 11:56:14 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 18/18] page_pool: access ->pp_magic through struct
 netmem_desc in page_pool_page_is_pp()
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, toke@redhat.com, tariqt@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com
References: <20250604025246.61616-1-byungchul@sk.com>
 <20250604025246.61616-19-byungchul@sk.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250604025246.61616-19-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/25 03:52, Byungchul Park wrote:
> To simplify struct page, the effort to separate its own descriptor from
> struct page is required and the work for page pool is on going.
> 
> To achieve that, all the code should avoid directly accessing page pool
> members of struct page.

Just to clarify, are we leaving the corresponding struct page fields
for now until the final memdesc conversion is done? If so, it might be
better to leave the access in page_pool_page_is_pp() to be "page->pp_magic",
so that once removed the build fails until the helper is fixed up to
use the page->type or so.

-- 
Pavel Begunkov


