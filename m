Return-Path: <bpf+bounces-6350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30654768581
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 15:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46EB41C209CF
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 13:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC9E1FD6;
	Sun, 30 Jul 2023 13:19:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CA2363
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 13:19:55 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04CB10B
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 06:19:54 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bc0d39b52cso1277655ad.2
        for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690723194; x=1691327994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xe19FSyqVMtSJothuV+9HnDqwn9ZBzV0WLnzrMtLXqI=;
        b=V/qUzZPl2C2fJiVrHo1ek0bN6LOIbGz0QJ2SNo0yUiouo4yAk+SZbOXMvIMbLmOL+Q
         PNyEmwTg+lr+3oW/M2WEwzyb3XVJohKAFYERiXUACMMOevkatBUAtDmDGzgTRlQbXEed
         Kp3b2KOR1aeyyT7WpYmSa/iByeX+NpQ+oAhxxWZp3A7upUn+t4wB9WTtvd6tDrwlibV/
         wS82SrERCEN0prQsTVUaK/solx2On8AiHoIcl1EcXnKY6madqoTeHDX2KfO4ACzUTQWq
         6zqppNtcYDpnaF1qMOlYy7P7fJcMoDID4PHAVUbJuDwDka/KE8uKmjmvP4ewlVfu9cwh
         s74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690723194; x=1691327994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xe19FSyqVMtSJothuV+9HnDqwn9ZBzV0WLnzrMtLXqI=;
        b=SRArD4fYLzD1N4JFzXMm/MTB2POEE6UA1Wt1m5OuENC9WIPjRNzSGEsViUWOt53hiQ
         sAe8b9k+pLQdFJm7kn+TMgcyxp4GaGTitYmc9k7uiN9UbFwpm9D+cTqLbsb4N968Url2
         6QXqVDBlkNxilkla5cZkjgdjiEqOMwj+Z+ookbqyKw2M0/vNGw2WAKRrmF1vRyp6Lalx
         VWwA3Ph9vFMzYb+6LAh5E2k9vEBFZvNzxAHv6ks/DZRlI+hOP5IDrMHg1yOzV+8AZ5kC
         e7Ij4TWzmU2gZSNwgZBmTd/L3/RDsnH0ASrxk5P/ZANWmW1JpWYt33++gyDE5YpEmhgl
         3qHg==
X-Gm-Message-State: ABy/qLadvmX0uD0G3MI55Q99UPh4QAXKKwIJM2gNlDHXdNfdnw1flOUf
	QFSvtFtmzV/PYgYiwe3fMzk=
X-Google-Smtp-Source: APBJJlFhLL4w/TUxkKxMNKA43NH01EhQ9PdJy4NpTiPDx0o9DsuWqs8TzldfKmK5wA/8g3crgaqq8Q==
X-Received: by 2002:a17:902:70c7:b0:1ba:1704:8a12 with SMTP id l7-20020a17090270c700b001ba17048a12mr6487132plt.45.1690723194166;
        Sun, 30 Jul 2023 06:19:54 -0700 (PDT)
Received: from [192.168.1.9] ([222.252.65.171])
        by smtp.gmail.com with ESMTPSA id w5-20020a1709029a8500b001b03cda6389sm6658317plp.10.2023.07.30.06.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 06:19:53 -0700 (PDT)
Message-ID: <cc5a6736-5fa8-1bae-8649-e113fb32c483@gmail.com>
Date: Sun, 30 Jul 2023 20:19:51 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] samples/bpf: Fix build out of source tree
Content-Language: en-US
To: Stanislav Fomichev <sdf@google.com>
Cc: ast <ast@kernel.org>, daniel <daniel@iogearbox.net>,
 andrii <andrii@kernel.org>, "martin.lau" <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>,
 linux-kernel-mentees <linux-kernel-mentees@lists.linuxfoundation.org>
References: <2ba1c076-f5bf-432f-50c1-72c845403167@gmail.com>
 <CAKH8qBtJ-Nb--BqH+J6K4S++J7J-8uHTPewS3BrVA86GBry=sQ@mail.gmail.com>
From: Anh Tuan Phan <tuananhlfc@gmail.com>
In-Reply-To: <CAKH8qBtJ-Nb--BqH+J6K4S++J7J-8uHTPewS3BrVA86GBry=sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/28/23 23:30, Stanislav Fomichev wrote:
> On Thu, Jul 27, 2023 at 5:43 PM Anh Tuan Phan <tuananhlfc@gmail.com> wrote:
>>
>> This commit fixes a few compilation issues when building out of source
>> tree. The command that I used to build samples/bpf:
>>
>> export KBUILD_OUTPUT=/tmp
>> make V=1 M=samples/bpf
>>
>> The compilation failed since it tried to find the header files in the
>> wrong places between output directory and source tree directory
> 
> I was going to test it locally, but I can't apply it. Patchwork also
> complains about the same issue:
>   stderr: 'error: corrupt patch at line 33
> 
> Are you copy-pasting it to gmail maybe? (or manually edited it after
> git format-patch?)
> Maybe rebase, and resend properly with git send-email?
> 
It was the copy paste problem. I rebased and sent again by git
send-email. Sorry for the inconvenient.


