Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277DC2531AC
	for <lists+bpf@lfdr.de>; Wed, 26 Aug 2020 16:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHZOoi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Aug 2020 10:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgHZOod (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Aug 2020 10:44:33 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD42C0613ED
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 07:44:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k20so1510884qtq.11
        for <bpf@vger.kernel.org>; Wed, 26 Aug 2020 07:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=3fltz4Tid80yvbd7ycd5CEvXCm5Dl/pplKlQTmdAxKA=;
        b=k4m5mEJBWpHKc8UCyiMSoWpLFbB9PLsFXQSse1GeHDwA4DKW/bxLFf2oq06iweP+iL
         M8bgXdl0A9155UGa8Nz8VJmE6L39gWW8oVIXtrtnNW2XbaFdQ7/KhobmLnk55ujnHV/2
         tPPob3cH4BlQEISinoXdsc01CEIIJiQYM7T+gkUDqRjYhkY6CbBd83M1+SskyHHbWLvL
         rHtzPGZUMHG7eDyNL2Q4ZV/nAiZIzogvhqr+a2Knoik0r52ut2ISFzGOCWsps3sZCmxq
         fBsjIPcK+lwVA+ap0kK3kVNC6i6d4qEdXhZRr9MSKdg1iPVBdKJXwariY86XZf+E2JPH
         +9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3fltz4Tid80yvbd7ycd5CEvXCm5Dl/pplKlQTmdAxKA=;
        b=l3wnaGrLJNnrNqT4XwmHnWsj2uBhB4/4+Ld9dMnJhPE7cD8ZGkdI8YFSOKBEYrRIJI
         5M7EqA6SgIPoDCwtiNo7+BFSgqBoCEEMBV5nXfWz3xOLz/Qf21Fkp/VaFbnx4QqzN0tu
         ju/eayynQh8pQexwVayXLcJIRuYV7cIxROurq4p7niDw8+G7gsGRLz2zX0lJc5QgX1zy
         GvFnZgvyVyjzP1a+LwUFud78IjIjZulLeaJ7+5J+xsHwoS4tHrxgl1uCyMQoPFuOQ1A+
         6/TRHO/Wpfk9OKdxFkn9uYWstXV4hpAyfiQBXKm8VRu5R9BaqcBkh/khH3+Ob0T26HdF
         Tq+A==
X-Gm-Message-State: AOAM531XmicgrgMdZQJ2jXNujJGfvSowgwdILGi+oAsygYZfOIyaz1OZ
        viMhfIzpx5Zz1hIsoEuanYCTIg==
X-Google-Smtp-Source: ABdhPJzCRDv2m2NsfRzSYdU3punl1WmSuoZIWY3X6Qrw3w/UZAKmzNkoM0/3I601SkHanbswK7RLyw==
X-Received: by 2002:ac8:33a1:: with SMTP id c30mr10693591qtb.156.1598453071797;
        Wed, 26 Aug 2020 07:44:31 -0700 (PDT)
Received: from skullcanyon ([192.222.193.21])
        by smtp.gmail.com with ESMTPSA id a203sm1862906qkg.30.2020.08.26.07.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:44:31 -0700 (PDT)
Message-ID: <aade022eeea9d9196774d0f21cbdaa118de8f885.camel@ndufresne.ca>
Subject: Re: [PATCH 00/49] DRM driver for Hikey 970
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Dave Airlie <airlied@gmail.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Wanchun Zheng <zhengwanchun@hisilicon.com>,
        linuxarm@huawei.com, dri-devel <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Bogdan Togorean <bogdan.togorean@analog.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Liwei Cai <cailiwei@hisilicon.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, Rob Herring <robh+dt@kernel.org>,
        mauro.chehab@huawei.com, Rob Clark <robdclark@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Liuyao An <anliuyao@huawei.com>,
        Network Development <netdev@vger.kernel.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        BPF Mailing List <bpf@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Date:   Wed, 26 Aug 2020 10:44:28 -0400
In-Reply-To: <20200825133025.13f047f0@coco.lan>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
         <20200819152120.GA106437@ravnborg.org>
         <20200819153045.GA18469@pendragon.ideasonboard.com>
         <CALAqxLUXnPRec3UYbMKge8yNKBagLOatOeRCagF=JEyPEfWeKA@mail.gmail.com>
         <20200820090326.3f400a15@coco.lan>
         <20200820100205.GA5962@pendragon.ideasonboard.com>
         <CAPM=9twzsw7T=GD6Jc1EFenXq9ZhTgf_Nuo71uLfX2W33oa=6w@mail.gmail.com>
         <20200825133025.13f047f0@coco.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Le mardi 25 août 2020 à 13:30 +0200, Mauro Carvalho Chehab a écrit :
> Em Tue, 25 Aug 2020 05:29:29 +1000
> Dave Airlie <airlied@gmail.com> escreveu:
> 
> > On Thu, 20 Aug 2020 at 20:02, Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com> wrote:
> > > Hi Mauro,
> > > 
> > > On Thu, Aug 20, 2020 at 09:03:26AM +0200, Mauro Carvalho Chehab wrote:  
> > > > Em Wed, 19 Aug 2020 12:52:06 -0700 John Stultz escreveu:  
> > > > > On Wed, Aug 19, 2020 at 8:31 AM Laurent Pinchart wrote:  
> > > > > > On Wed, Aug 19, 2020 at 05:21:20PM +0200, Sam Ravnborg wrote:  
> > > > > > > On Wed, Aug 19, 2020 at 01:45:28PM +0200, Mauro Carvalho Chehab wrote:  
> > > > > > > > This patch series port the out-of-tree driver for Hikey 970 (which
> > > > > > > > should also support Hikey 960) from the official 96boards tree:
> > > > > > > > 
> > > > > > > >    https://github.com/96boards-hikey/linux/tree/hikey970-v4.9
> > > > > > > > 
> > > > > > > > Based on his history, this driver seems to be originally written
> > > > > > > > for Kernel 4.4, and was later ported to Kernel 4.9. The original
> > > > > > > > driver used to depend on ION (from Kernel 4.4) and had its own
> > > > > > > > implementation for FB dev API.
> > > > > > > > 
> > > > > > > > As I need to preserve the original history (with has patches from
> > > > > > > > both HiSilicon and from Linaro),  I'm starting from the original
> > > > > > > > patch applied there. The remaining patches are incremental,
> > > > > > > > and port this driver to work with upstream Kernel.
> > > > > > > >  
> > > > > ...  
> > > > > > > > - Due to legal reasons, I need to preserve the authorship of
> > > > > > > >   each one responsbile for each patch. So, I need to start from
> > > > > > > >   the original patch from Kernel 4.4;  
> > > > > ...  
> > > > > > > I do acknowledge you need to preserve history and all -
> > > > > > > but this patchset is not easy to review.  
> > > > > > 
> > > > > > Why do we need to preserve history ? Adding relevant Signed-off-by and
> > > > > > Co-developed-by should be enough, shouldn't it ? Having a public branch
> > > > > > that contains the history is useful if anyone is interested, but I don't
> > > > > > think it's required in mainline.  
> > > > > 
> > > > > Yea. I concur with Laurent here. I'm not sure what legal reasoning you
> > > > > have on this but preserving the "absolute" history here is actively
> > > > > detrimental for review and understanding of the patch set.
> > > > > 
> > > > > Preserving Authorship, Signed-off-by lines and adding Co-developed-by
> > > > > lines should be sufficient to provide both atribution credit and DCO
> > > > > history.  
> > > > 
> > > > I'm not convinced that, from legal standpoint, folding things would
> > > > be enough. See, there are at least 3 legal systems involved here
> > > > among the different patch authors:
> > > > 
> > > >       - civil law;
> > > >       - common law;
> > > >       - customary law + common law.
> > > > 
> > > > Merging stuff altogether from different law systems can be problematic,
> > > > and trying to discuss this with experienced IP property lawyers will
> > > > for sure take a lot of time and efforts. I also bet that different
> > > > lawyers will have different opinions, because laws are subject to
> > > > interpretation. With that matter I'm not aware of any court rules
> > > > with regards to folded patches. So, it sounds to me that folding
> > > > patches is something that has yet to be proofed in courts around
> > > > the globe.
> > > > 
> > > > At least for US legal system, it sounds that the Country of
> > > > origin of a patch is relevant, as they have a concept of
> > > > "national technology" that can be subject to export regulations.
> > > > 
> > > > From my side, I really prefer to play safe and stay out of any such
> > > > legal discussions.  
> > > 
> > > Let's be serious for a moment. If you think there are legal issues in
> > > taking GPL-v2.0-only patches and squashing them while retaining
> > > authorship information through tags, the Linux kernel if *full* of that.
> > > You also routinely modify patches that you commit to the media subsystem
> > > to fix "small issues".
> > > 
> > > The country of origin argument makes no sense either, the kernel code
> > > base if full of code coming from pretty much all country on the planet.
> > > 
> > > Keeping the patches separate make this hard to review. Please squash
> > > them.  
> > 
> > I'm inclined to agree with Laurent here.
> > 
> > Patches submitted as GPL-v2 with DCO lines and author names/companies
> > should be fine to be squashed and rearranged,
> > as long as the DCO and Authorship is kept somewhere in the new patch
> > that is applied.
> > 
> > Review is more important here.
> 
> Sorry, but I can't agree that review is more important than to be able
> to properly indicate copyrights in a valid way at the legal systems that
> it would apply ;-)

Regardless of the "review-ability", our users distribute the Linux
Kernel as a whole, so who contributed which specific line of code is
already lost in a way. All we see in the distribution if a list of
copyright holder and licenses. In this context, the per patches
ownership have no legal implication. My two, non lawyer cents.

> 
> In any case, there's an easy way to make the code easy to review:
> I can write the patches against staging (where it is OK to submit
> preserving the history) and then add a final patch moving it out
> of staging.
> 
> You can then just review the last patch, as it will contain the
> entire code on it.
> 
> Another alternative, as I'm already doing with Sam, is for me to
> submit the folded code as a reply to 00/xx. You can then just 
> review the final code, without concerning about how the code reached
> there.
> 
> From review point of the view, this will be the same as reviewing
> a folded patch, but, from legal standpoint, the entire copyright
> chain will be preserved.
> 
> Thanks,
> Mauro

