Return-Path: <bpf+bounces-9556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1DD79915A
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 23:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E92928156C
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 21:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2F520E2;
	Fri,  8 Sep 2023 21:03:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0488B30FA3
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 21:03:20 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A39DC
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 14:03:19 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5924093a9b2so24693887b3.2
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 14:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694206999; x=1694811799; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VYaRZhRWe9s16/bj/V0ZxDqhOreSubKxeSNAm6RQ174=;
        b=ZPNGBIQqG9w5AX5KoULtn7Iww6f7fvR3ckLjW8RUmsvDVx1zeBdApip2SI4/lBv0Uu
         8z3LD4CFLa8A1lrUSB7magF2IAqf0M221vKCpf3gczqw1BbbVJq4WAhaIlci9SLIGR7o
         iZ0GkaBn470GlyHL40gvw07rIYE/HniEVk33z7R3iOYU/B/B+Jg/VA1T0XyuYUHA+myJ
         enaYGDWgzG88D3MOMubaVLvdUA4oJvI2qc3urG+eMgpNRCZNvgv2sf4X8sfzeH0VOhEF
         xSeMiCOEVRUaRKfDdKBXItlOr2kzsALDV9TFtTC3dSlVrXY+LbzHs5KZzxWWBihfuOoc
         bliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694206999; x=1694811799;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYaRZhRWe9s16/bj/V0ZxDqhOreSubKxeSNAm6RQ174=;
        b=OlIs0ERPRej3bzIFNdPV+1ishhgUezqfOfMdcqWtXcHbBkfHPMXDxv2NIEprZXdAcq
         LvDFiFWfIAnNVtlsAVSuHFpTX1WN5J6otmkIkih7ZUNtuHfSAy5GprI/yrE++w+w6UiG
         NUNGbvKf2uca6XetFxmlReb9aHQb5FM+Yw+7wJoe2AKXhoyF93UC1H0Vt20etrehExRt
         RnqYqsCVATcwpIdOyFPW3A2QbqeTWoFFnBDq0osCr8Q6QgDWWlhScC2bwNV/bl75L/TC
         POlmiO3vaCun78YH0NBeTd3Vzo+oxOIXGgGQHnLQ+BwD0xqTjy/8/2M/fDMAkvMaA0d2
         Cx8A==
X-Gm-Message-State: AOJu0YyfLhAvQOQ3ZYtG5nNshebZbY2S83qIe+5BMTnS6epxlabIzlpy
	HHk6aXjDb8Dw+eyuO8VKTB8=
X-Google-Smtp-Source: AGHT+IFmaJtrxhvc4HopuxXX+NARYfn4V8TDgUm9QFfu5t9iNb238K9GRVaLckkOK+/ue+T8IDITjw==
X-Received: by 2002:a81:840d:0:b0:586:9ccb:b5ad with SMTP id u13-20020a81840d000000b005869ccbb5admr3619346ywf.46.1694206999020;
        Fri, 08 Sep 2023 14:03:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ca10:ff1b:4740:238d? ([2600:1700:6cf8:1240:ca10:ff1b:4740:238d])
        by smtp.gmail.com with ESMTPSA id u70-20020a0deb49000000b00559fb950d9fsm627821ywe.45.2023.09.08.14.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 14:03:18 -0700 (PDT)
Message-ID: <b1c35333-013b-2f3a-e6cd-c00530e8a6cf@gmail.com>
Date: Fri, 8 Sep 2023 14:03:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC bpf-next] Registering struct_ops types from modules.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Kui-Feng Lee <kuifeng@meta.com>
References: <20230907203202.90790-1-thinker.li@gmail.com>
 <CAADnVQLAmvNewqyVUZkcFt8RRvs+W0RJfyExa-gZ=-0-nwL16A@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAADnVQLAmvNewqyVUZkcFt8RRvs+W0RJfyExa-gZ=-0-nwL16A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/8/23 11:24, Alexei Starovoitov wrote:
> On Thu, Sep 7, 2023 at 1:32 PM <thinker.li@gmail.com> wrote:
>>
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Resend to remove noise!
>>
>> Given the current constraints of the current implementation, struct_ops
>> cannot be registered dynamically. This presents a significant limitation
>> for modules like fuse-bpf, which seeks to implement a new struct_ops
>> type. To address this issue, here it proposes the introduction of a new
>> API. This API will enable the registering of new struct_ops types from
>> modules.
>>
>> The following code is an example of how to implement a new struct_ops type
>> in a module with the proposed API. It adds a new type bpf_testmod_ops in
>> the bpf_testmod module. And, call register_bpf_struct_ops() and
>> unregister_bpf_struct_ops() when init and exit the module.
> 
> register_bpf_struct_ops() api implementation is missing in the diff.

Sorry for the confusion!
The purpose of this RFC to check how people think about the API itself.

