Return-Path: <bpf+bounces-15624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384137F3BC6
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 03:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41CF282B40
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 02:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9386F848E;
	Wed, 22 Nov 2023 02:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVwaNF7C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73B5198
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 18:28:38 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-58a0154b4baso185619eaf.1
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 18:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700620118; x=1701224918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xkBb8m6qg52Rccn7KP03knxnX+FdsRI1KUkITZVxZvE=;
        b=QVwaNF7CKLuW0Yc0jVt3EhWahGAWukd/nDId8bszPYe+I1yOLk+VTj3hfUkTxso555
         bNH2FBuYCWys9YP+ZupOsaVBby359y2U9uBXZIZ1aPeVQgZLJu2Oaa+HVK+pTlR2rxRB
         2slTB4151WX9s2SaVuEOxMbciFtQv0PXyGxpjKSA8T9slC+IT/6BRpjlbo32SjBRZamO
         NlBT+EOVNetOs4OZ909Q5kb3AMP/HiltpVDsflpsw3myUb8+mXVYyJETKWK7EoUoJOzt
         Op7Lv29mD2IocsNTc0qFEqFXyO6KMHPHrQfJyvtql8j6cHFG+sPzAs2eUMjdeiIiEuyF
         Btkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700620118; x=1701224918;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkBb8m6qg52Rccn7KP03knxnX+FdsRI1KUkITZVxZvE=;
        b=xE0mmWtM6/es6FEN8W2Sn5+b52qh7JOBZFmZ+/9lxIPlo2EKD7Pqv+thtCdfPz6U/n
         4S9yjvMoqtLjV1BikjNhEtDAiHykZRYWdHGRUX8c8e3n4tzxxpEQDtqTaUQ1W2seJ7Uh
         QNh9K4HrwWsSLmqbg4JLCsVXVqOZSUBfDeinrLquTDXZYMo6BlJ5fxvm/aaLDswkjnQn
         lWXoRq6pRxNxrXFS7dd3LJQThRp1CNbNDJizzNfMql92xJX39moB0vE3DVwiZy6wdqnw
         QJq9kl1ofCpEYIfdF2EUujy8OD4faoLi1WhiNKaEOzfKTKcvZYrlS5+piM19TJ4HBg0J
         Wl+w==
X-Gm-Message-State: AOJu0YzSl6Nm31oBLTM5ie29py5RvN5PcHA4WXaeHDLnTS9/Y2XvZMo1
	dkAXvdLOtRYX43qJpSQE768=
X-Google-Smtp-Source: AGHT+IEjUvsxlyFrk/qleGYmMqZe8VGt17tiMahXhLP+KVsnlxDro6EPnpK+8uf1djF8SbGwxc0NWw==
X-Received: by 2002:a05:6870:9f05:b0:1f9:906f:d3ce with SMTP id xl5-20020a0568709f0500b001f9906fd3cemr177434oab.17.1700620118264;
        Tue, 21 Nov 2023 18:28:38 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:ef40:7e31:9d9d:46c4? ([2600:1700:6cf8:1240:ef40:7e31:9d9d:46c4])
        by smtp.gmail.com with ESMTPSA id z18-20020a9d7a52000000b006d7e1d3dedasm441885otm.32.2023.11.21.18.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 18:28:37 -0800 (PST)
Message-ID: <63b1c5c4-a188-4403-84e8-ab0fd66f6a06@gmail.com>
Date: Tue, 21 Nov 2023 18:28:36 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v11 05/13] bpf: make struct_ops_map support btfs
 other than btf_vmlinux.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231106201252.1568931-1-thinker.li@gmail.com>
 <20231106201252.1568931-6-thinker.li@gmail.com>
 <30c577d9-ac4d-8cb9-bd59-44feaff01896@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <30c577d9-ac4d-8cb9-bd59-44feaff01896@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/9/23 17:40, Martin KaFai Lau wrote:
> On 11/6/23 12:12 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Once new struct_ops can be registered from modules, btf_vmlinux is not
> 
> s/not/no/ longer the only ...
> 
>> longer the only btf tht struct_ops_map would face.  st_map should 
>> remember
> 
> s/tht/that/ (?)
> 
>> what btf it should use to get type information.
> 
> 
Fixed! Thanks!

