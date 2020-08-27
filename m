Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC28254B6F
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 19:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgH0RCv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 13:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgH0RCu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Aug 2020 13:02:50 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E554C061264
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 10:02:50 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id a34so3326237ybj.9
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 10:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4m+hmGk2KBXeELO5szTujMxeAL1STNjr9OgA1hZdwHE=;
        b=uP3y4+QK4dOuP+5d+++WaP2V5ndi/LaX4WAt5j6Y2G9L9SpH2lZ5f0W8ZrR4mdtpoO
         paB3nrggM4W2CXuHVXvS4Q+/d1Y2ZKICgFe9HGZGIWE4ZDkinyyYApv2cqm10OBSx54f
         QIda3kRBQML6Ji77Le0UUmqfEfjcsFaxaxz6DnFrXLVGWpZ+16hdK+hc1APkBJLnp5Te
         aqwVU83/0qDjVy4k1id0vsD+aHwMszKiA6ZLuLbFUf/gq5zOm4hioZnaBkc5GgRPXDjN
         Vokcz779zxuq/DqU6tLpxtJ+wWgoly60imK4CRqWVGVkIG4NM4B2I2j8GFd+BzNjmUll
         VM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4m+hmGk2KBXeELO5szTujMxeAL1STNjr9OgA1hZdwHE=;
        b=BfWzyCiA/Gxr2TGYcZYN5zy3iFFGwKfN63swAfxelveza10EMd8PueF4G+bsQ5x3Gx
         zsa+GXipmFPzDA338KRvSYpL6iwxlQGFKGU+y5GEnOIcag/JRC4sH6P4SjZctUzRu2WI
         kb9RkNCnNshB36t0kV4jiypCYe+kaAYI+W4zSTfkh5mdYv4Cq44QA4UwkcFhvHVcKZna
         CRKvW7j57wrunK8EVaLT2vZrlmPCKXIXCAOO3BaIhPYeYyMIRigsQy9RRGZiu5CILKHw
         aDuWMUdXOzI7nfKZQbAjOAODR9dNkDV4gs80vlOHlK469VkSbJVCvSftLBNTMfO66aja
         P0Kg==
X-Gm-Message-State: AOAM5316XX80Of10QroB7sAB3cd/gJaAZBir70wKyCU/hVavbsi1b+kg
        AHbj+K8diJZiX3DeuBHi+AgZphSLpUfD+vgSLIw=
X-Google-Smtp-Source: ABdhPJymd8pzoMi5/U9ADTiAGI+ok4JwonMqdkPWqWPENBZtlJXpun6J35yJR4B6r5bUs2IVgonRX6pbr15SBTnRhDA=
X-Received: by 2002:a25:6b4e:: with SMTP id o14mr29007171ybm.506.1598547769076;
 Thu, 27 Aug 2020 10:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhV9ERe4VwPrrwDJF4xqmaeyqQqPvYaY2Wb9DEk8tf-GB_-Yw@mail.gmail.com>
 <b8a11771-7b7c-a3b1-0639-dc4706ef3ecf@gmail.com> <CAHhV9ERrtpmNdAmM0-evExLi=iC0wkwTByw5AqBbSQv9CbaNow@mail.gmail.com>
 <01775dda-3e00-708a-1433-a1facb79db3d@gmail.com>
In-Reply-To: <01775dda-3e00-708a-1433-a1facb79db3d@gmail.com>
From:   Abhishek Vijeev <abhishek.vijeev@gmail.com>
Date:   Thu, 27 Aug 2020 22:32:37 +0530
Message-ID: <CAHhV9ETbOHxBJMHZ57PmmZ1vovwn+g=LNuJEJFio4ouD6xQWkw@mail.gmail.com>
Subject: Re: Frozen Maps
To:     David Ahern <dsahern@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yes, that's precisely why I reached out.

Thank you.

On Thu, Aug 27, 2020 at 10:19 PM David Ahern <dsahern@gmail.com> wrote:
>
> On 8/27/20 10:43 AM, Abhishek Vijeev wrote:
> > Thank you.
> >
> > To confirm, is this the only way?
>
> appears so from a code review. I am surprised it is not in GET_INFO
> response.
