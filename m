Return-Path: <bpf+bounces-4603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 850F174D6D4
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 15:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B181C20AC1
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 13:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1F111C8B;
	Mon, 10 Jul 2023 13:04:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5791101C6
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 13:04:07 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8294619B6
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 06:03:44 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666e97fcc60so2749084b3a.3
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 06:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688994208; x=1691586208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sAy2c0os0GmfNuU+dP0Ym0b6T3GH3G+Bfmw/OZdFCgA=;
        b=FCXvc+q7Ckt/Vm7rCBLYwtu0LzCUVodERKRMLt1iNehEnwPhXk7B7YdwRBZguFQQZU
         uCsN3B9prfW4KSe6tzCLwuCU8pLw+MJJQ4asbzpSB3GI+ttYOXOgIOkvbjTzdQDcIJz3
         rv0xT4r5ZxVziOwUBCIBfCrYvt6SXuNBdmK21NbnIE+1dEd8CTzEep5GURTbqfqPXFKW
         kWYMm5u73PVzTOHJq9bmoUerEGfaMmhfVsX75K22i/PxXrp+4VqdvIi+zESX5Pb5WcQb
         kd3whsdyuOt8JRHeqI0Yzw6qF1mWIhP/1iL1ztH/16xR+IKwAVvrtnqoJnMyw37lNzN1
         3lUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688994208; x=1691586208;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sAy2c0os0GmfNuU+dP0Ym0b6T3GH3G+Bfmw/OZdFCgA=;
        b=RriN8UmlHqdObtLRqZMApjxSiPF0R6DntWino4f0g3pyqAC90w2FHLdHNtNEew/LC7
         gXfBf9qDEMJo6aT9vNY0D56g3CyxQ2cHJPwluRIYPZhQvdFQIaQ9N8pQrf+TrSSp3aZu
         gP63bgnnOoKKI0/uhx60N9mLDCmh3YcxSUVCQ6o5H29CblsMNvVjGHBQMHaWKhi0KM4x
         IJgsz9e29HJtMeTqWXnEI+Fnc2JsupT1kvPVqF/8+dG0zvCpuEvzR++zEg4D8JmWNicB
         NufR3WuX28jYqajGuJFXnVV7hQMaETbxD0tR4rqkp/U6A9jeP+AGmErJ1KYteEOyl2Go
         IQiQ==
X-Gm-Message-State: ABy/qLbIr4+X0m1wAuH9Mz1xiQk7Bsmksc6BU75t95tO9jfPzZPot8S+
	/CkjM0W8TG79F7F83LbAJoI=
X-Google-Smtp-Source: APBJJlGKb+QmQtzOeC8zSxJUy+5B2v3C4XCt6WZ+bphJfsuHYCeRR/Jy5UJdbRBMMo0S218d/ywsyg==
X-Received: by 2002:a05:6a20:728e:b0:131:bcaf:9b with SMTP id o14-20020a056a20728e00b00131bcaf009bmr2333454pzk.30.1688994207687;
        Mon, 10 Jul 2023 06:03:27 -0700 (PDT)
Received: from [192.168.1.9] ([14.238.228.104])
        by smtp.gmail.com with ESMTPSA id s2-20020a639242000000b00553c09cc795sm7446422pgn.50.2023.07.10.06.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 06:03:27 -0700 (PDT)
Message-ID: <4bf6475b-6688-1b6d-0db1-b0f15d2e1b3d@gmail.com>
Date: Mon, 10 Jul 2023 20:03:23 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] samples/bpf: Add more instructions to build
 dependencies and, configuration in README.rst
Content-Language: en-US
To: Siddh Raman Pant <sanganaka@siddh.me>,
 Khalid Masum <khalid.masum.92@gmail.com>
Cc: daniel <daniel@iogearbox.net>,
 linux-kernel-mentees <linux-kernel-mentees@lists.linuxfoundation.org>,
 andrii <andrii@kernel.org>, ast <ast@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
 "martin.lau" <martin.lau@linux.dev>
References: <bd1477f2-a51e-a795-4f25-a32d6ab46530@gmail.com>
 <ZKcE+wMWGdVFSBX2@google.com>
 <32d67707-b831-9a98-4cb9-fcb27c8806ef@gmail.com>
 <ZKhEEJfzCyYI7BfH@google.com>
 <5d336a9a-8ae5-2b1f-7af3-a94818867b40@gmail.com>
 <CAABMjtHc4Vu=_L4rOhy1a-m0nQ-ptHe68qXJd__mSQAgO+t_iw@mail.gmail.com>
 <1893b4bf70a.2c44c261262941.883099013045252156@siddh.me>
From: Anh Tuan Phan <tuananhlfc@gmail.com>
In-Reply-To: <1893b4bf70a.2c44c261262941.883099013045252156@siddh.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/9/23 22:36, Siddh Raman Pant wrote:
> On Sun, 09 Jul 2023 20:51:15 +0530, Khalid Masum wrote:
>> However, something to think about is: If future versions of clang, llvm etc
>> do not support compiling our code as it is now, it may become misleading.
> 
> When that happens, the max version can be added in.
> 
> Though, it would be an indicator to problems in the code IMO,
> which would need some updates and fixes.
> 
> So nothing to worry about now.
> 
> Anh should send v3 instead of replying though. I would also suggest
> to shorten the commit title if possible.
> 
> Thanks,
> Siddh
> 

Thank you! Will send a new version accordingly. But I'd like to admit
that the v2 in this patch's title is a mistake. This should be v1 so
I'll send a v2 patch for this discussion.

