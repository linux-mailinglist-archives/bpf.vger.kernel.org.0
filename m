Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A6040D80F
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 12:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbhIPK7S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Sep 2021 06:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237575AbhIPK7O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Sep 2021 06:59:14 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3A3C061766
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 03:57:54 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id e26so4485907wmk.2
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 03:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gvciQBRjdKJ+epYnhvh12uEei/mAg84fmaGrBTbZwcI=;
        b=sl7KqI7lXKNlZd5Y2NBZmthXWE0BxN9jJBaEcMPqwByQ+vRVxh1sDf+na7WazEiqYF
         jr/fIpeNebDrVKtnJEzpukm1192/nx13KL3YaEhtn8FY5dDxR3bMmxVu4KQvOJpBNEyM
         ErzJ70IPQT/l3oFI/qqAQtuzq1cn8Pi5/J8rkrbDFVMI6EmD3ic2+pSiYiXd2P/X9i1f
         HOF5mH+/dxe9BH1qqdHBCn5z8qYH/jKb3Erp/2kdORiF8ny0FjMm4EaTbVt0gBvMgfl1
         eISpp3j9juqaDsZ1zpIFvMSRbKPFZqPk5TwEAV7j8UaunWJyoeUaSCUGBPQj+7TsDr8B
         pKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gvciQBRjdKJ+epYnhvh12uEei/mAg84fmaGrBTbZwcI=;
        b=IgMa5cCY9pK+tGbU0stQPr3A3uRx//G+dlX4sBM4RtbdtnrTj+pAG+1uNzctRsGlt0
         R9A5t7JIAmz8wxTbdAGDwCbH18q8sVhN+6Z4iHyQZEeiHcWDzcbt30ovkfe2321MNQyr
         aJBLDx43mH7eTFa4LVWLwLTo1rTGeH0WNqzQjVt2Ovpy+0gtUBELiQzWPwx+a+tClbQN
         2K9zrpXudrJRJtPWp4UMT/q7Az/G16fBJgNODB1LP9nD4ghB+9H6e7bylgnqeUNvvIxm
         OfRE265XeT1pqmnWVQqAM1EQWxZXQYM+h+Jx7MkJclX4bxdezPwQ5HDUOBUcbN42DsDA
         RQGw==
X-Gm-Message-State: AOAM532dd4G0PmEet7ztLRGQvdA7KVGFEnqkbZ+uF0MGLjIMhnDS3zm7
        mBCce5PXLnQlhuaiYzXiqxzOVw==
X-Google-Smtp-Source: ABdhPJwy1PAeu6n9GWTT6elODrsFuP2EWjwg7KZZ18iKsZn2ewdDTJg2LA13SB/rsk3pKcvLU7haSg==
X-Received: by 2002:a7b:cd0f:: with SMTP id f15mr4416172wmj.173.1631789872597;
        Thu, 16 Sep 2021 03:57:52 -0700 (PDT)
Received: from [192.168.1.8] ([149.86.87.95])
        by smtp.gmail.com with ESMTPSA id b16sm3067515wrp.82.2021.09.16.03.57.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Sep 2021 03:57:52 -0700 (PDT)
Subject: Re: [PATCH 08/24] tools: bpftool: update bpftool-prog.rst reference
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Beckett <david.beckett@netronome.com>,
        Jakub Kicinski <kuba@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
 <dc4bae7a14518fbfff20a0f539df06a5c19b09de.1631783482.git.mchehab+huawei@kernel.org>
 <eb80e8f5-b9d7-5031-8ebb-4595bb295dbf@isovalent.com>
 <20210916124930.7ae3b722@coco.lan>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <33d66a49-2fc0-57a1-c1e5-34e932bcc237@isovalent.com>
Date:   Thu, 16 Sep 2021 11:57:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210916124930.7ae3b722@coco.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-09-16 12:49 UTC+0200 ~ Mauro Carvalho Chehab
<mchehab+huawei@kernel.org>
> Hi Quentin,
> 
> Em Thu, 16 Sep 2021 10:43:45 +0100
> Quentin Monnet <quentin@isovalent.com> escreveu:
> 
>> 2021-09-16 11:14 UTC+0200 ~ Mauro Carvalho Chehab
>> <mchehab+huawei@kernel.org>
>>> The file name: Documentation/bpftool-prog.rst
>>> should be, instead: tools/bpf/bpftool/Documentation/bpftool-prog.rst.
>>>
>>> Update its cross-reference accordingly.
>>>
>>> Fixes: a2b5944fb4e0 ("selftests/bpf: Check consistency between bpftool source, doc, completion")
>>> Fixes: ff69c21a85a4 ("tools: bpftool: add documentation")  
>>
>> Hi,
>> How is this a fix for the commit that added the documentation in bpftool?
>>
>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>> ---
>>>  tools/testing/selftests/bpf/test_bpftool_synctypes.py | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/test_bpftool_synctypes.py b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
>>> index be54b7335a76..27a2c369a798 100755
>>> --- a/tools/testing/selftests/bpf/test_bpftool_synctypes.py
>>> +++ b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
>>> @@ -374,7 +374,7 @@ class ManProgExtractor(ManPageExtractor):
>>>      """
>>>      An extractor for bpftool-prog.rst.
>>>      """
>>> -    filename = os.path.join(BPFTOOL_DIR, 'Documentation/bpftool-prog.rst')
>>> +    filename = os.path.join(BPFTOOL_DIR, 'tools/bpf/bpftool/Documentation/bpftool-prog.rst')
>>>  
>>>      def get_attach_types(self):
>>>          return self.get_rst_list('ATTACH_TYPE')
>>>   
>>
>> No I don't believe it should. BPFTOOL_DIR already contains
>> 'tools/bpf/bpftool' and the os.path.join() concatenates the two path
>> fragments.
>>
>> Where is this suggestion coming from? Did you face an issue with the script?
> 
> No, I didn't face any issues with this script.
> 
> The suggestion cames from the script at:
> 
> 	./scripts/documentation-file-ref-check
> 
> which is meant to discover broken doc references. 
> 
> Such script has already a rule to handle stuff under tools/:
> 
> 		# Accept relative Documentation patches for tools/
> 		if ($f =~ m/tools/) {
> 			my $path = $f;
> 			$path =~ s,(.*)/.*,$1,;
> 			next if (grep -e, glob("$path/$ref $path/../$ref $path/$fulref"));
> 		}
> 
> but it seems it needs a fixup in order for it to stop reporting issues
> at test_bpftool_synctypes.py:
> 
> 	$ ./scripts/documentation-file-ref-check 
> 	...
> 	tools/testing/selftests/bpf/test_bpftool_synctypes.py: Documentation/bpftool-prog.rst
> 	tools/testing/selftests/bpf/test_bpftool_synctypes.py: Documentation/bpftool-map.rst
> 	tools/testing/selftests/bpf/test_bpftool_synctypes.py: Documentation/bpftool-cgroup.rst

Oh, I see, thanks for explaining. I didn't know this script would catch
the paths in bpftool's test file.

> 
> I'll drop the patches touching it for a next version, probably
> adding a fix for such script.
> 
> Thanks,
> Mauro
> 

Sounds good to me, thanks a lot!
Quentin
