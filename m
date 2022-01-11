Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B0A48A65D
	for <lists+bpf@lfdr.de>; Tue, 11 Jan 2022 04:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbiAKDds (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jan 2022 22:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiAKDds (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Jan 2022 22:33:48 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1914C06173F
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 19:33:47 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id rj2-20020a17090b3e8200b001b1944bad25so3424376pjb.5
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 19:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k7REKW+ck8+r9lKjjx7haqJyrFBXQvgkEswSHT4TqBw=;
        b=CUrUsHfTgriIhuyp2mmxLyiI9cfVMXzXLpHvrSJZfv0EemZ+PlhZ0o+QOihb4Z/mCp
         HxQ3Ni3x+8gUGw7pzZGBFoFTg9vZv3W15NHUYYWIb2s+rnVFfpmIoOIOxJfGch2ZnowN
         bQyj5AU/1WJ6XhPB1q7Lq+zAw0bIBymfw//XEtZd4pIoBzIaFSyCluPXZ0J22zxHna03
         ozuX1Hh2F/aXrM70cZkAHPTM77kzaEtKXFQ22WPJbNkHlSLqXErcKO/A2M5sWZCAzrZs
         MgjQZckbrXafkGoieJipEZt6s+lVbuwUl3ONCtANL0eyu65RsM+Eo4o4tuJYCLd8b8Qj
         H1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k7REKW+ck8+r9lKjjx7haqJyrFBXQvgkEswSHT4TqBw=;
        b=awXixQLP08NvlV/S8G/dG5R5G/HsoQkgueCB4uX5LPPWPx0LZcPCCmDf8/lCvJbLSj
         eI+FYoj8JJQPJR21xbA7EizaOXJz7AiPgY4iwc3SectclLgGOnw4jiCkwEh7BaLds3kg
         QeVgrHofJF1M3EwF/RLXt/dYIU2f+gILUHvaDaWjY7hOEm0WzGdTv3OcVsxU68AAPNIa
         Vyz9oj4nrHifvTOGAXDyOZ8kAtscLxAVxPJ79anMJnA3Trs1ztoi/csV1dJTReQG0fYO
         O6W++z+z6k0r+N5M/C/+xuIP1hnrczl4moqG0sBbfF4FlbT6uzye8qNu4WOVQC3XuZEq
         zIng==
X-Gm-Message-State: AOAM533/RTSO6G6yDb5DyOXPdmFf75M/ekOuIv86100iwknXmHBuqO42
        7O0L4LOKIily/vPcwK0wkWM=
X-Google-Smtp-Source: ABdhPJxh3iiJ+YdjjNnt9d3AvKdoFz5mEoMkUYf+OeNvx3kuFrEHeYwrlI2SnKmibpD0C5Lmzh+Asw==
X-Received: by 2002:a17:902:7785:b0:149:5945:40ac with SMTP id o5-20020a170902778500b00149594540acmr2698803pll.35.1641872027307;
        Mon, 10 Jan 2022 19:33:47 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:f4d1])
        by smtp.gmail.com with ESMTPSA id u8sm8215373pfi.147.2022.01.10.19.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 19:33:46 -0800 (PST)
Date:   Mon, 10 Jan 2022 19:33:44 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Hao Luo <haoluo@google.com>
Cc:     sdf@google.com, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>, bpf@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v1 0/8] Pinning bpf objects outside bpffs
Message-ID: <20220111033344.n2ffifjlnoifdgnj@ast-mbp.dhcp.thefacebook.com>
References: <20220106215059.2308931-1-haoluo@google.com>
 <Ydd1IIUG7/3kQRcR@google.com>
 <CA+khW7h4OG0=w5RXnentwnsi614wZdpYW4EUwN6k7Vce3unBKw@mail.gmail.com>
 <YdiTrq4Y7JwmQumc@google.com>
 <CA+khW7ihrLZwvzPTGAy0GyFmKzB7tH-FU6D+-fthqbj4wuiwFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7ihrLZwvzPTGAy0GyFmKzB7tH-FU6D+-fthqbj4wuiwFg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 10, 2022 at 10:55:54AM -0800, Hao Luo wrote:
> 
> I see. With attach API, are we also able to specify some attributes
> for the attachment? For example, a property that we may want is: let
> descendent cgroups inherit their parent cgroup's programs.

Plenty of interesting ideas in this thread. Thanks for kicking it off.
Maybe we should move it to office hours?
The back and forth over email can take some time.
It sounds to me that "let descendents inherit" is a mandatory feature.
In that sense "allow attach in kernfs" is not a feature. It feels that
it's creating more problems for the design.
Creating a "catable" file inside cgroup directory that descedents inherit
with the same name is a cgroup specific feature.
Inherit or not can be a flag, but the inheritance needs to be designed
from the start.

echo "rm" is not pretty. 
fsnotify feels a bit hacky.
Maybe pinning in cgroupfs will avoid both issues?
We can have normal unlink implemented there.

The attach bpf_sys cmd as-is won't work. It needs a name at least.
That will make it look like obj_pin cmd. So probably better to make
obj_pin work when path is inside cgroupfs and use file_flags for
inherit or not.
The patch 8 gives a glimpse of how the bpf prog will look like.
Can you make it more realistic?
Do you need to walk cgroup children? Or all processes in a cgroup?
Will we need css_for_each_descendant() as a bpf helper?
