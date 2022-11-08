Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F68621B83
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 19:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiKHSLe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 13:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiKHSLN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 13:11:13 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8685985F
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 10:11:09 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id p21so14873764plr.7
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 10:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tHpH8m6dgNfiQPxxaI+ie/h8su/JmgsuAtTRCP2y7Jg=;
        b=O13ss8Piqdoz6ev8eJwKMXAomsogEW4iV7vBS9YYpNHAjnbJXiDGfkaOX+dOYPFxBN
         cPQX00/lS+08J3I9P79PRq42SYVjm2OR5fLUgYC8WBBZQbCn2yy9eY7XLKC7DvhVrVrR
         /mDEtWAM3JK4jYl/IIJGONx25lGJ42Z5xepMjM9qVAHO9ly4pfJe9fdXqShs84ME/Nk4
         Yj/lbHNt4oCcCJbIEk9usKpeqPGopIbREeJnAkpl8LosleN+q85073MW62jhLLnvN9bF
         PIiHIw1u04PV2JL+p+uPHoVbqFgopxeujXfWz/tbmq+wzNRJRTfQ5btjZXuVqQ3xir4m
         VRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHpH8m6dgNfiQPxxaI+ie/h8su/JmgsuAtTRCP2y7Jg=;
        b=yEWW6/Xw3LWr99XS8kZCNPk80kMGGNamsaqtc+6MK+fhgjniTcFLayOfwYq7UokOFX
         ptQ6KZOHtleoekViGiIpfQIw3nFFOAeIWGLK89KEpAoJPE3g4LK1B2nhUUe4XqF9K4sz
         c1pxugIvly3VWd7e5fF0ROjSqFCR1VWTMmgQK8sW6Le+JsZ/Px8W41DVVLz5mYIIrSxi
         MEAbRtB+s59CfnLvmkhXzMCneX3lZnUJWiY6DUlM4RjH26bsT3yH0tiE17DI006k2I//
         cGrLHMLgozCBOCd6xgrTTGZI8eye8ZWv02xT+z+w+cQx/33no0oIURngICBeGW4+nQyr
         HpKQ==
X-Gm-Message-State: ACrzQf17kR9zxnRlT/ycYq1/BhyLCxFdM8xSSg+s8lApKcSf2gDvRO4a
        XuCuAJPpGBdJ4btK4xgwnh1imXa4uhJQ/g9rOQ0lkQ==
X-Google-Smtp-Source: AMsMyM7zLoAvC+T8T8AFpnAtSEQDnx1uOWRgwmXadR9NbmtBRPtdKmTMMiPmvsmKX+sLVolkycbDNKIv09m7NBABs6I=
X-Received: by 2002:a17:902:bd45:b0:186:9efb:71fe with SMTP id
 b5-20020a170902bd4500b001869efb71femr58912993plx.128.1667931068612; Tue, 08
 Nov 2022 10:11:08 -0800 (PST)
MIME-Version: 1.0
References: <20221107074222.1323017-1-houtao@huaweicloud.com>
 <20221107074222.1323017-2-houtao@huaweicloud.com> <a4721692-82bf-05eb-a1fa-72ddb5d1461b@meta.com>
 <CA+khW7jmm4UWXve_kzXdh4sv8cFbFKNYQ-G-XCJ6qGRW1_verg@mail.gmail.com>
 <8bae6a03-9d31-2da5-1b7d-cf5c74e76cfd@huaweicloud.com> <a85181da-99dc-d3a3-53c7-96584dbad8bf@meta.com>
 <0ad23bcc-b4dd-307f-f188-1181efaa3e53@huaweicloud.com>
In-Reply-To: <0ad23bcc-b4dd-307f-f188-1181efaa3e53@huaweicloud.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 8 Nov 2022 10:10:57 -0800
Message-ID: <CA+khW7gfKkCHOMTBtNcFdfCVDsvmZPfgDT5tPZVF=j2m-pBZbg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/3] bpf: Pin the start cgroup in cgroup_iter_seq_init()
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Tejun Heo <tj@kernel.org>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 8, 2022 at 5:28 AM Hou Tao <houtao@huaweicloud.com> wrote:
> On 11/8/2022 3:03 PM, Yonghong Song wrote:
> > On 11/7/22 8:08 PM, Hou Tao wrote:
> >> On 11/8/2022 10:11 AM, Hao Luo wrote:
<...>
> >>> There is an alternative: does it make sense to have the iterator hold
> >>> a ref of the link? When the link is closed, my assumption is that the
> >>> program is already detached from the cgroup. After that, it makes no
> >>> sense to still allow iterating the cgroup. IIUC, holding a ref to the
> >>> link in the iterator also fixes for other types of objects.
> >>
> >> Also considered the alternative solution when fixing the similar problem in bpf
> >> map element iterator [0]. The problem is not all of bpf iterators need the
> >> pinning (e.g., bpf map iterator). Because bpf prog is also pinned by iterator fd
> >> in iter_open(), so closing the fd of iterator link doesn't release the bpf
> >> program.
> >>
> >> [0]: https://lore.kernel.org/bpf/20220810080538.1845898-2-houtao@huaweicloud.com/
> >
> > Okay, let us do the solution to hold a reference to the link for the iterator.
> > For cgroup_iter, that means, both prog and cgroup will be present so we should
> > be okay then.
> >
> The reason I did not use the solution is that it will create unnecessary
> dependency between iterator fd and iterator link and many bpf iterators also
> don't need that. If we use the solution, should I revert the fixes to bpf map
> iterator done before or keep it as-is ?
> >

Hou Tao, on the contrary, I do think the dependency is necessary. My
understanding is, the lifetime of an iterator should not go beyond the
lifetime of the link who generates the iterator.

You mention that many bpf iterators don't need that. I suspect there
are bugs due to lack of such dependencies. Hypothetically, if the link
is released, it may cause the program to be released as well. Then,
how could we still iterate the objects and call the program on the
objects? Please correct me if there is anything I missed.
