Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA9236C59F
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 13:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhD0Lwt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 07:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbhD0Lws (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 07:52:48 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB734C061574
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 04:52:04 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 8so25852393qkv.8
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 04:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X2BjKbKMJR4ItsquQUqnKgfqPfYEx2HUH9Z/myAc97s=;
        b=xkGYMa3BL4EeMvVsjlHhv0PllBhdriJINPY3S9GAvDLtgzaozbq1F4UemPzr5emzUh
         ThXk2bM8Wd+/v6pDHYzRdLGSmH74/IYFLrI9VbEBlA2qMv35w7TsO/KkBWXopLPeexld
         6K8T696BNBOsrUUStxO5EAaMIW6G4NkBtJV74MxDf3u+NTVcvfYO+Dp9aKiTf7zheqNE
         hbHdf1wQHiG6ixF87Xvn9+VjEjMyNiq5fcQFw5vLXGknON9xq51qaJ/o9SqnGJs2PPUK
         T7T0mZWJ3V6fqa8gyMHqgUEXVD3P0BDz5PMQ9iln+1ty8+itIu0nzIUgl3qNYfdWI3m7
         fBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X2BjKbKMJR4ItsquQUqnKgfqPfYEx2HUH9Z/myAc97s=;
        b=MFHiDccRRY0M2bycp/hdBOL5ScSKCPQG3JpOVZShzIyQYc1PCs1MbQsbhKMXzG5voZ
         nY2+f6rD+FOI6ubK5xNhJB9jPCv2QNYVaOZrCOXXlLbLpAEL4mek2DcKqf9pbWb5AU8A
         XIgGlp40ONQRV0i3bhXCJy+6v79+9b1CVM2fh+5yQLVb7/Yr+wyVi2n/+Aa79BPzusUg
         iagyb6XBkH1x5YltjMGxxcOJaNZjw5ge7SHP+FKjx+muNpN1ZTfFhcepmTwrHdGH71Kj
         a0i6wR6bj5aVk3URNdhSJzY9SmgdT6D0P16GfApOVHCK3xPGVO5+8OsbzSSF2ztuQdBz
         VEDg==
X-Gm-Message-State: AOAM530jKuHiHmLAATwGH5VEbtFbAwFhhvlKI6nVNHgb7xd7UF+qslXr
        H13AfJouhKSGrL8yaDntN+vooQ==
X-Google-Smtp-Source: ABdhPJzwOLNmn5EACDdBrjCcZQlfLnGlMB0aKEVG6ot4PM8WBuafOUaLIGtksb45XYrDFagj9K5K8A==
X-Received: by 2002:a37:b987:: with SMTP id j129mr22130887qkf.174.1619524324141;
        Tue, 27 Apr 2021 04:52:04 -0700 (PDT)
Received: from [192.168.1.79] (bras-base-kgtnon0881w-grc-68-142-114-51-86.dsl.bell.ca. [142.114.51.86])
        by smtp.googlemail.com with ESMTPSA id d6sm13718272qtn.52.2021.04.27.04.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 04:52:03 -0700 (PDT)
Subject: Re: [RFC Patch bpf-next] bpf: introduce bpf timer
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Dongdong Wang <wangdongdong.6@bytedance.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Pedro Tammela <pctammela@mojatatu.com>
References: <20210402192823.bqwgipmky3xsucs5@ast-mbp>
 <CAM_iQpUfv7c19zFN1Y5-cSUiVwpk0bmtBMSxZoELgDOFCQ=qAw@mail.gmail.com>
 <20210402234500.by3wigegeluy5w7j@ast-mbp>
 <CAM_iQpWf2aYbY=tKejb=nx7LWBLo1woTp-n4wOLhkUuDCz8u-Q@mail.gmail.com>
 <20210412230151.763nqvaadrrg77kd@ast-mbp.dhcp.thefacebook.com>
 <CAM_iQpWePmmpr0RKqCrQ=NPiGrq2Tx9OU9y3e4CTzFjvh5t47w@mail.gmail.com>
 <CAADnVQLsmULxJYq9rHS4xyg=VAUeexJTh35vTWTVgjeqwX4D6g@mail.gmail.com>
 <CAM_iQpVtxgZNeqh4_Pqftc3D163JnRvP3AZRuFrYNeyWLgVBVA@mail.gmail.com>
 <CAADnVQLFehCeQRbwEQ9VM-=Y3V3es2Ze8gFPs6cZHwNH0Ct7vw@mail.gmail.com>
 <CAM_iQpWDhoY_msU=AowHFq3N3OuQpvxd2ADP_Z+gxBfGduhrPA@mail.gmail.com>
 <20210427020159.hhgyfkjhzjk3lxgs@ast-mbp.dhcp.thefacebook.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <34af20ce-b749-7e37-2658-9aca6304614a@mojatatu.com>
Date:   Tue, 27 Apr 2021 07:52:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210427020159.hhgyfkjhzjk3lxgs@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2021-04-26 10:01 p.m., Alexei Starovoitov wrote:

[..]
>>
>> They are already in CC from the very beginning. And our use case is
>> public, it is Cilium conntrack:
>> https://github.com/cilium/cilium/blob/master/bpf/lib/conntrack.h
>>
>> The entries of the code are:
>> https://github.com/cilium/cilium/blob/master/bpf/bpf_lxc.c
>>
>> The maps for conntrack are:
>> https://github.com/cilium/cilium/blob/master/bpf/lib/conntrack_map.h
> 
> If that's the only goal then kernel timers are not needed.
> cilium conntrack works well as-is.

IIRC, the original patch from Cong was driven by need to scale said
conntracking in presence of large number of flows.
The arguement i heard from Cong is LRU doesnt scale in such a setup.

I would argue timers generally are useful for a variety of house
keeping purposes and they are currently missing from ebpf. This
despite Cong's use case.
Currently things in the datapath are triggered by either packets
showing up or from a control plane perspective by user space polling.

Our use case (honestly, not that it matters to justify why we need
timers) is we want to periodically, if some condition is met in the
kernel, to send unsolicited housekeeping events to user space.

Hope that helps.

cheers,
jamal

