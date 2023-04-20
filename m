Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DDA6E865C
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 02:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjDTAXf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 20:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjDTAXe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 20:23:34 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D37110D8
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 17:23:33 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-24782fdb652so266931a91.3
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 17:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681950213; x=1684542213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wDtA3n1gGbF6RiRyIkr0iVT9HzDmjzkIl/vdMPFwf7c=;
        b=pXz4tMCZHM6PrkeBsnF4RQzVU5c2X1hk92nncx506qb9y06gluuzpFZPfwLdmQuztp
         ynMDX/B+yiooC3U9Gplq2AQapovcSHdQAWtraHq9QUdR6WKyJ9vRqiDr410H3fBM3/Dv
         f1AS+M5HyI0pDw7/ve639zh6gii+PNlNMG0rSOIbBOVKY4h5+iq71LW2vZMrpy/ExHQ9
         ny+5YDY7UToUxuKz9k0ubkI7BcK0SxkVCo5KRy80p8W7oW2HT7z5WqvqfG6Mf16H/zjm
         E7GiozPERnTSlWdYMaIrGdUJgQ41UKdURmwiSjdFMBmRzYJauRc2j5crY/wSr1+3r6Jb
         gDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681950213; x=1684542213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDtA3n1gGbF6RiRyIkr0iVT9HzDmjzkIl/vdMPFwf7c=;
        b=QV9SPEYJd9H2DYH007IdjOqAPeZEmMcuqnlt3oh/zGcmZwmpf728I7971rORQ9B4JK
         O5OqgW8mG8WGuc2MqOBVxikkxgItbNixb62ukVUoNNAncFZonW0xaz9BKBhtLFrlx9VM
         4nCxy7mk9OvrlEwvTBdd/VOVUpxp6lTAgs1e92L6YL4wgDUleySSFLUCd94XsM2DsSqn
         KQHXwZgy+epLeBQfbMrB9P5w4Vh7p9Gs2O7lGmA6A6VdcJI2lGp/OkmEdtHz2jmE9wHS
         5NaVNN3cg/uWR/2K/6yWj4UVsl3SXZt6Y+3QiI3bP4xfbKxmX4SNXj0u+grofVsARvGU
         5/rw==
X-Gm-Message-State: AAQBX9fK5s2yMpB/kkUQXHHkhyG/KcMP7BLaovWsPf3iibL/H4nzHrmQ
        SXJcDwLAQhqx/lAKPUcMaVc=
X-Google-Smtp-Source: AKy350YNyg6ihGFXad6EBiUdxFWZyXvRrF6GNLFl94gmZoZYprBpaoogSqq8PLykErsFatYGLQWH5w==
X-Received: by 2002:a17:90b:297:b0:249:67d3:b932 with SMTP id az23-20020a17090b029700b0024967d3b932mr4357257pjb.30.1681950212796;
        Wed, 19 Apr 2023 17:23:32 -0700 (PDT)
Received: from ?IPV6:2620:10d:c085:21e1::11e9? ([2620:10d:c090:400::5:b0fd])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b0019aeddce6casm32122plb.205.2023.04.19.17.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 17:23:32 -0700 (PDT)
Message-ID: <3e26f771-60bb-3bf6-d94c-28dacdc5e01c@gmail.com>
Date:   Wed, 19 Apr 2023 17:23:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next v2] bpftool: Show map IDs along with struct_ops
 links.
Content-Language: en-US, en-ZW
To:     Quentin Monnet <quentin@isovalent.com>,
        Kui-Feng Lee <thinker.li@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        yhs@meta.com, song@kernel.org, kernel-team@meta.com,
        andrii@kernel.org, Kui-Feng Lee <kuifeng@meta.com>
References: <20230419003651.988865-1-kuifeng@meta.com>
 <CACdoK4K1WjBrm6jcF7zhFSn8VN2BhBHtWubzVira-Xiiz+JV7Q@mail.gmail.com>
From:   Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CACdoK4K1WjBrm6jcF7zhFSn8VN2BhBHtWubzVira-Xiiz+JV7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thank you for reviewing this.

On 4/19/23 16:25, Quentin Monnet wrote:
> On Wed, 19 Apr 2023 at 01:37, Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> A new link type, BPF_LINK_TYPE_STRUCT_OPS, was added to attach
>> struct_ops to links. (226bc6ae6405) It would be helpful for users to
>> know which map is associated with the link.
>>
>> The assumption was that every link is associated with a BPF program, but
>> this does not hold true for struct_ops. It would be better to display
>> map_id instead of prog_id for struct_ops links. However, some tools may
>> rely on the old assumption and need a prog_id.  The discussion on the
>> mailing list suggests that tools should parse JSON format. We will maintain
>> the existing JSON format by adding a map_id without removing prog_id. As
>> for plain text format, we will remove prog_id from the header line and add
>> a map_id for struct_ops links.
>>
>> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
>> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> 
> Looks all good from my side, thank you.
