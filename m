Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D44A929511
	for <lists+bpf@lfdr.de>; Fri, 24 May 2019 11:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389582AbfEXJrG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 May 2019 05:47:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50959 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390046AbfEXJrG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 May 2019 05:47:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id f204so8683882wme.0
        for <bpf@vger.kernel.org>; Fri, 24 May 2019 02:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dOqJpOAI6HvYYtPXGw4CVVj27veh7KmTbOLYsz53/gg=;
        b=wx/H2dDumegNZHRe1HZk642M5tqwiSWsdJKXelX0ggaArNukLxCQiRzfO4DPAaQsdw
         FzjijVJuqYEqz6UPDDbGz19UTmeqigxKbNGhfbeXjCHUrJMlZY0fmiRSD/xK9vkNxKyN
         IWa4wu20kD3Kd15BRt7bm0+7NKcyl2z8DJZqbYaGRcaAHgrqRGzCkKM6D6+CSvf3Np8N
         PFgDhXE8nIJs1vIbPCd7tps5tva1g/N4noD4NaZ+VDMBh/vXLH0+GtM6Gn/1EtBD2fRq
         Xgpi67BggqHLuC4iFIUdRKuVcfoiCCP+7PhiNHZO/YNAqfO4zVk11GGmSEUJ/f4R78ud
         IwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dOqJpOAI6HvYYtPXGw4CVVj27veh7KmTbOLYsz53/gg=;
        b=IrzRIKqBsxC32s/O9d0YRZlkdLsBCirPhWCk8Jf3QedzBM/YqHq0z+tHdlBxeqbdn+
         jdD7JWltiPdgSjDkcnfrN0NcN/cuD3mkXcdlMLooa7ScDmduCh4aKKviNISGy+ONxhgb
         UQ+xfGAT81aAjK8ZAP2X3MB0xcULCKxvOqJ/N20YDUwTcwA2tVbfeZeTDf+8BY4s81Lh
         mmNRa6b+65jcBa8c8zdzTJGkhyVzuwUwFsaeDzFjJOu07wkLBTYM7o4axTELIqJXKQ8I
         IpLanwBHitXLbp3bx4zogu3YXlnbtqiFF+BpkqOGJosKNqVLrznrpiBbNwHHLdeE7q3t
         aa8A==
X-Gm-Message-State: APjAAAXLQD/idtG0Xd8yKYkfQiIHjy7v+nbwzrgFQALZLelRg39rZEJY
        oe+8k8VJNk+3FgKM9suclg4bt4SAXDc=
X-Google-Smtp-Source: APXvYqymEL4op2zF3iHVs5rUyqgLtQSJwbR0FquD6ijiGdZ+ex3aHMk/XMLzo+k+reDK6VaEdh5vuQ==
X-Received: by 2002:a05:600c:21d2:: with SMTP id x18mr5523493wmj.112.1558691223769;
        Fri, 24 May 2019 02:47:03 -0700 (PDT)
Received: from [192.168.1.2] ([194.53.186.20])
        by smtp.gmail.com with ESMTPSA id y18sm2306558wmd.29.2019.05.24.02.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 02:47:03 -0700 (PDT)
Subject: Re: [PATCH bpf-next v2 2/3] libbpf: add bpf_object__load_xattr() API
 function to pass log_level
To:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "oss-drivers@netronome.com" <oss-drivers@netronome.com>
References: <20190523105426.3938-1-quentin.monnet@netronome.com>
 <20190523105426.3938-3-quentin.monnet@netronome.com>
 <d9d1d907-9f0d-7fc0-3f2d-dde5081e8bd3@fb.com>
 <1d6ec594-5564-3b35-f134-055d8ff4eb0f@fb.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Message-ID: <698c672e-f818-4b66-ebfc-e0b33964dec0@netronome.com>
Date:   Fri, 24 May 2019 10:47:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1d6ec594-5564-3b35-f134-055d8ff4eb0f@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2019-05-23 16:29 UTC+0000 ~ Yonghong Song <yhs@fb.com>
> 
> 
> On 5/23/19 9:19 AM, Yonghong Song wrote:
>>
>>
>> On 5/23/19 3:54 AM, Quentin Monnet wrote:
>>> libbpf was recently made aware of the log_level attribute for programs,
>>> used to specify the level of information expected to be dumped by the
>>> verifier.
>>>
>>> Create an API function to pass additional attributes when loading a
>>> bpf_object, so we can set this log_level value in programs when loading
>>> them, and so that so that applications relying on libbpf but not calling
>> "so that so that" => "so that"

Oh, thanks!

>>> bpf_prog_load_xattr() can also use that feature.
>>
>> Do not fully understand the above statement. From the code below,
>> I did not see how the non-zero log_level can be set for bpf_program
>> without bpf_prog_load_xattr(). Maybe I miss something?

bpf_prog_load_xattr() already had support for passing a log_level, it
was added by Alexei when he made libbpf aware of the different log
levels (commit da11b417583e). But bpftool does not rely on
bpf_prog_load_xattr(), it loads programs with bpf_object__load(), that
offered no way pass a log_level parameter. Does that help?

> 
> Looks like next patch uses it when -d is specified.

It uses the new bpf_object__load_xattr() function introduced in this
patch indeed.

> Probably commit message can be made more clear.

Yeah, probably. I'll improve it and submit a v3.

Thanks!
Quentin
