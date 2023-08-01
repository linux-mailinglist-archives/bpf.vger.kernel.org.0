Return-Path: <bpf+bounces-6517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1114976A7A6
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 05:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A2F1C20E2C
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 03:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160AF2109;
	Tue,  1 Aug 2023 03:48:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6037E;
	Tue,  1 Aug 2023 03:48:06 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBDA18E;
	Mon, 31 Jul 2023 20:48:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686f090310dso5213360b3a.0;
        Mon, 31 Jul 2023 20:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690861684; x=1691466484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jV8C2r+kVaNU7+6evg1ZUzf56TmpgZkWuXutDoGyoos=;
        b=HvmpnXaGt+36Hs6XALFtVWEHOto1VVSPavgL1hfk0mIQkXxYEPcMhe+qRF3FV0bQyx
         stficwg9nPmLIhdY+CEaeaoX13ZIjYmeIIfV9yaoQOzEoYmaydOPrmYwj/hdpcaKLKIp
         RM+3FkiwfIDNE++n5aA8bqjcjRDOpht3WkKhwaCOOzWCV0Dyte+zSqi6YH8VXrtfpl5d
         lBTsWY+Ib9FTdNKDg1VlYl13STqtb02meSPrdXsWDh00ES+YE0gpx09+ecJutr8gdqeR
         eXv/GDNc48Nsnt77ZtPXxjfzKJ0gZ6RrOIWiyuuxDbmgDCTzricRH/F/H0Qi9mQZzsV/
         MR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690861684; x=1691466484;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jV8C2r+kVaNU7+6evg1ZUzf56TmpgZkWuXutDoGyoos=;
        b=cZh0gNYKJvGmNCIYhW+1+DWTXThagT46Cw1R+vVlq6ge2t4c65VEHUYauyXnCtlvZG
         tcO9riH4rzxsfAp3xUs/XOnJZnPS7mlh/7rFsGV7tG3Usi6JP7MrG085Eoem3mJKH1PH
         GvuBo7KjTT8bcRYwCRMUaRuGgQEw5b7qeYxEPA5dufdxHAV2jUoslmjahtyyacabA4OU
         EQ4Kf1gHj1SB9vqjWds/ZGVLnKxo47hwW54iDacUBrDE7Dvv8sv1xjOxMPqJ/tgoaCSL
         Fsnuf6fgxQ7BdPdx6+RxqYCKHJG5r8I7X3h+e7mWzSls8hXleIjt4EjEdf753KV0U3z0
         HF3Q==
X-Gm-Message-State: ABy/qLaGs+oCpZbVQv3fcsPJ09MJhg9Df+bq69HrfDfmxAwtmNdi5DLs
	+LAUxaf4DQsZKqGEuJkdyMQ=
X-Google-Smtp-Source: APBJJlHjSMsgYDkJ43FxsVLUamk5zy3asg/j77+lCmWCJFhjD1JGMuL1Tt58uaXEshNAk5orn7XUpA==
X-Received: by 2002:a05:6a20:85:b0:13b:cc09:a547 with SMTP id 5-20020a056a20008500b0013bcc09a547mr9985987pzg.36.1690861684538;
        Mon, 31 Jul 2023 20:48:04 -0700 (PDT)
Received: from [10.22.68.111] ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id ey2-20020a056a0038c200b006829969e3b0sm8217599pfb.85.2023.07.31.20.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 20:48:04 -0700 (PDT)
Message-ID: <b04eb1f8-b36a-9fce-5ae5-d4c770c36139@gmail.com>
Date: Tue, 1 Aug 2023 11:47:58 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v4 1/2] bpf, xdp: Add tracepoint to xdp attaching
 failure
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, hawk@kernel.org,
 rostedt@goodmis.org, mhiramat@kernel.org, mykolal@fb.com, shuah@kernel.org,
 tangyeechou@gmail.com, kernel-patches-bot@fb.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230730114951.74067-1-hffilwlqm@gmail.com>
 <20230730114951.74067-2-hffilwlqm@gmail.com>
 <20230731194336.5b4bd065@kernel.org>
From: Leon Hwang <hffilwlqm@gmail.com>
In-Reply-To: <20230731194336.5b4bd065@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 1/8/23 10:43, Jakub Kicinski wrote:
> On Sun, 30 Jul 2023 19:49:50 +0800 Leon Hwang wrote:
>> @@ -9472,6 +9473,7 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>>  	struct bpf_link_primer link_primer;
>>  	struct bpf_xdp_link *link;
>>  	struct net_device *dev;
>> +	struct netlink_ext_ack extack;
> 
> This is not initialized. Also, while fixing that, move it up 
> to maintain the line order by decreasing line length.
> 

Thank you for your reviewing.

I'll fix it by initializing extack and moving the line to its appropriate position.

Thanks,
Leon

>>  	int err, fd;
>>  
>>  	rtnl_lock();
>> @@ -9497,12 +9499,13 @@ int bpf_xdp_link_attach(const union bpf_attr *attr, struct bpf_prog *prog)
>>  		goto unlock;
>>  	}
>>  
>> -	err = dev_xdp_attach_link(dev, NULL, link);
>> +	err = dev_xdp_attach_link(dev, &extack, link);
>>  	rtnl_unlock();
>>  
>>  	if (err) {
>>  		link->dev = NULL;
>>  		bpf_link_cleanup(&link_primer);
>> +		trace_bpf_xdp_link_attach_failed(extack._msg);

