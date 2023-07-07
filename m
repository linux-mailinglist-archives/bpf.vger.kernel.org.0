Return-Path: <bpf+bounces-4427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C908174B23E
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 15:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052611C20FAF
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 13:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4E7D2E3;
	Fri,  7 Jul 2023 13:51:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B675733D0
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 13:51:43 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B472708
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 06:51:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-666fb8b1bc8so1594597b3a.1
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 06:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688737882; x=1691329882;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6Iantu54ZuEmJPSontbxiYXeQ/uVqcnAm95dc5tYGWA=;
        b=cIGOoBBO/Goe8+eNUd5wDyMH5LoNn7XgsE7WKW8hUSF7/z6bTAzkWIYPniQfhE+O8r
         sVkgs1fwUYuFsZnUbnHEhWfl5EX3nPxhy875qaLakpWlPad4GHAnapJdFxi9Rc5fWSkY
         yA7dEwM9HUHU2cedBsUnE/UD2pT4NnO4vZF0OsfIyh53BkqMdbVDvegyW9eozLrD/d48
         fmezk8nR097iS1MnSx7MYiBNMMogT8LTqw8KaKmse/RZhQEmV5U97CX2B/pmNdKSviIm
         Vq0eG6edcnzG4aS8GYFOjhYhMxvtpTl2aiCrA20wlJ5jb4adirEpiQA91fUtss/fidrN
         Jthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688737882; x=1691329882;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Iantu54ZuEmJPSontbxiYXeQ/uVqcnAm95dc5tYGWA=;
        b=cVNOTtT7w7w+14X6Sa/VIBSDowFIrAaCe8v5b636azQwYgOq4Ov8/8fiuBRkP08SPZ
         /RZVmxwZMloa9M+Qffjwnp/VD2C/UqAmgHJef9ku+ew48LBBHRbmLfIMkqrACD2sk9QQ
         /njR+T6/0OCrL2GuImSWCce+FPy195Uui3dL6uRNXECfW7EdgG8yOUqjVSw+huShBWIZ
         1LTEjjB2m4I1ZzTkMPIEvdM9JyUmejkKD0ua2pRMV/meJKAlwjTYOGZXLglMCm+GYwc8
         9lu96cXuZrGMxa2O+3sBsLq0BzIJBH+ivaiela3+2jkswci3YksQHsoJgocy7K3Ryx6H
         Yycw==
X-Gm-Message-State: ABy/qLZZZGeDob15KUr4r1v9eGGGg5GKZ9eB0rSachNl8w/afpjT8ESu
	V9xo8cdFPNNoRX+5QAtkltk=
X-Google-Smtp-Source: APBJJlGp7WNiasg9ojoZCynU+KGGC9G6kkLMtkFYzj27RCGzd4sJZyjBycCv7Mygm/7QqS8YhQZbKQ==
X-Received: by 2002:a05:6a20:3c9e:b0:12f:bca:d9ae with SMTP id b30-20020a056a203c9e00b0012f0bcad9aemr5667657pzj.59.1688737881919;
        Fri, 07 Jul 2023 06:51:21 -0700 (PDT)
Received: from [192.168.1.9] ([14.238.228.104])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902b68d00b001a24cded097sm3283254pls.236.2023.07.07.06.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 06:51:21 -0700 (PDT)
Message-ID: <dc7a79e0-acfa-c65e-d9db-80806758f846@gmail.com>
Date: Fri, 7 Jul 2023 20:51:18 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] samples/bpf: Add more instructions to build
 dependencies and, configuration in README.rst
To: Ivan Orlov <ivan.orlov0322@gmail.com>
References: <bd1477f2-a51e-a795-4f25-a32d6ab46530@gmail.com>
 <4e4a3024-0482-665c-212f-f0084f404239@gmail.com>
Content-Language: en-US
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
 martin.lau@linux.dev
From: Anh Tuan Phan <tuananhlfc@gmail.com>
In-Reply-To: <4e4a3024-0482-665c-212f-f0084f404239@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks, will do

On 7/7/23 02:43, Ivan Orlov wrote:
> On 06.07.2023 20:00, Anh Tuan Phan wrote:
>> Update the Documentation to mention that some samples require pahole
>> v1.16 and kernel built with CONFIG_DEBUG_INFO_BTF=y
>>
>> Signed-off-by: Anh Tuan Phan <tuananhlfc@gmail.com>
>> ---
> 
> Minor nit: you should write what changed since the first version of the
> patch here, otherwise the changes are pretty hard to follow.

