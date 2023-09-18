Return-Path: <bpf+bounces-10320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB7A7A50E9
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 19:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E6E28149D
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F068D262AD;
	Mon, 18 Sep 2023 17:25:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4521F5E9
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 17:25:01 +0000 (UTC)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8029F120
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 10:24:59 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-77dcff76e35so59844539f.1
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1695057899; x=1695662699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XHmyNtZRGj+r/j/G7CbRibxxcZBx+UTQ5mP0xbLF240=;
        b=IE5+O2n0ShLxXU829jR1cINfhvWeMXuKxxmgOV/xM08cpVvbixRLLIRlHA3MkMXHOZ
         wj7od0nV265UlEfALm68RPTbDRACmwEQkalGfNRwgJRHjSjGyKeyeEjxXvibeeYrMW3l
         WH4J0ztK3mkbcmYx9AyI8ATHKHtGrjxPCStlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695057899; x=1695662699;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHmyNtZRGj+r/j/G7CbRibxxcZBx+UTQ5mP0xbLF240=;
        b=QsqYuidm2TJmdXLzz9IF5N+aBehZdcLhU7ccOUgWpRBMxYbdAy6fMkkoJHbMSj33kS
         nsFPwdmaB3GnkdXLIoOwl19ECkDD0LVi1UHyvlXB2Dnk+3QgaHNy8gDbalC2vaooCu5I
         P9SQ2+MkzWSixLt8631glS9neiLqPZh2WCX+eIajyckHD4upBED5Y+SichrI5Kxt92mD
         o5ZmNZWsEyslYxKGdwLQjIQZYHig+nCgKY7D47yz+x+4Yp/nAFuLpPsS9CdujDV75+R/
         6vLRnng788wFbBvySzu8pmo+IsXVDRfhzflcpXIoGbI8FHzD5JrEKA8J+VvMwYU23uaK
         6VOA==
X-Gm-Message-State: AOJu0YxbKfBztKSB7AYfZyCDdNEXLee/boyiOO8bCYggNjg4uPOLWXH7
	N2bFEkwmVa/pNM8gPbkzOxKWTw==
X-Google-Smtp-Source: AGHT+IG8zSvNfr6+khcoHiE7xQDRSFBwUFrI6G55nMfl8DKpv4GXtM1aJNknfr8iPELEl9G5ZXABiw==
X-Received: by 2002:a6b:3bce:0:b0:790:958e:a667 with SMTP id i197-20020a6b3bce000000b00790958ea667mr11136825ioa.2.1695057898872;
        Mon, 18 Sep 2023 10:24:58 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h15-20020a056602130f00b007911db1e6f4sm3056358iov.44.2023.09.18.10.24.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 10:24:58 -0700 (PDT)
Message-ID: <2535d4a7-62fe-c9b2-3b86-cf418760087e@linuxfoundation.org>
Date: Mon, 18 Sep 2023 11:24:57 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/3] selftests/hid: do not manually call
 headers_install
Content-Language: en-US
To: Justin Stitt <justinstitt@google.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 Shuah Khan <shuah@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, linux-input@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
 <20230908-kselftest-09-08-v2-2-0def978a4c1b@google.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230908-kselftest-09-08-v2-2-0def978a4c1b@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/8/23 16:22, Justin Stitt wrote:
> From: Benjamin Tissoires <bentiss@kernel.org>
> 
> "make headers" is a requirement before calling make on the selftests
> dir, so we should not have to manually install those headers
> 
> Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>

Thank for making this change. Just check bpf continues to
compile and run though.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

