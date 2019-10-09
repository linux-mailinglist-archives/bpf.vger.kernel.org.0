Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E588D14A6
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2019 18:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbfJIQyO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 12:54:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37363 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbfJIQyO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Oct 2019 12:54:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id p1so1783226pgi.4
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2019 09:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=FWquouYqKBd7amD18urRls6Y6gtLx6j4gbRFX8vfpcA=;
        b=tyktbH9E1xZYVxbf2IRLPSbtOnJAiG0rW/0c5WCWbuy8c4r8FPIL0X55nHn53qkQpd
         N/0S+JB9m39QziSsYYKCAt0JSnU9ZCny5eS0E0tEEUUs5p8ASxnapxafcxo3iwTuogAO
         lewh/W1lUFpKc43PnicB0nJs4hSDJF/47m+ONJ6pGRydxBwaILK1HUmGWqgLQiHKgsBN
         Sgmga5tkGNm+JYjXzDP+5PJotOy0P/8CgN/GOFbUsnDIGrUh0gZwDhpwaL3n7/OoLspN
         TPJD813EHaDL77sT6jHyKq86NZHc+V0V+lIM86k95Rpb9eCTfmAlm3U2rC/cuQYVmwV3
         kUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=FWquouYqKBd7amD18urRls6Y6gtLx6j4gbRFX8vfpcA=;
        b=kppSItKzmP3ZzjiyJtemPhz+3B2oNUM4BVlxMWZHjx2kCVJeSxJMKnF7Ht0BGNXMz9
         aDC+pygSfJEHXj6hdbfNESTnPFucHdHPkpstMtmYE25VaB8Sr+vh51Ws5H8FpAh7200V
         01YzIZtrIGI8X6GqwMxZDvFVf3PrvARczIOBHbRsWT/aIl3fkQYIJ+SN4JbymTl5IxfN
         FzyqkRqUg7Eqb4ZNtYCUJDhJf8PGycNmRIWliOAIUj6dVpXQFs2FABIRNLcWlYVw9RrA
         qsYnCh9f+JQa4mVkAHj9LiAQeOkJckv+Q1lfWRCrrj2dUZ7sxAXnoU4Hg3UQDfMkgj4e
         5sUA==
X-Gm-Message-State: APjAAAX6sOJ6rZlyyFhvpVG6GA9uiAdsAIpVPUo9Ppy7PN6Mq5iTiIPj
        duxN4o/l6wIPycSDlBCHSzYooAtwoIc=
X-Google-Smtp-Source: APXvYqz33xg6mGHwZzY2rBVPIF3+9OEjT1Iym8OqIXZgdg5lCtvXcB+wk3KGe6fY9b73P2JfvTAQ4g==
X-Received: by 2002:a17:90a:9e2:: with SMTP id 89mr5312445pjo.67.1570640051867;
        Wed, 09 Oct 2019 09:54:11 -0700 (PDT)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id r18sm4172935pfc.3.2019.10.09.09.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 09:54:11 -0700 (PDT)
Date:   Wed, 9 Oct 2019 09:53:58 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, maciej.fijalkowski@intel.com,
        tom.herbert@intel.com
Subject: Re: [PATCH bpf-next 0/4] Enable direct receive on AF_XDP sockets
Message-ID: <20191009095358.34cddd95@cakuba.netronome.com>
In-Reply-To: <ce255470-6bf7-0ba4-c24f-0808e3331977@intel.com>
References: <1570515415-45593-1-git-send-email-sridhar.samudrala@intel.com>
        <20191008174919.2160737a@cakuba.netronome.com>
        <ce255470-6bf7-0ba4-c24f-0808e3331977@intel.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 8 Oct 2019 23:29:59 -0700, Samudrala, Sridhar wrote:
> On 10/8/2019 5:49 PM, Jakub Kicinski wrote:
> > I asked you to add numbers for handling those use cases in the kernel
> > directly.  
> 
> Forgot to explicitly mention that I didn't see any regressions with 
> xdp1, xdp2 or xdpsock in default mode with these patches. Performance 
> remained the same.

I'm not looking for regressions. The in-kernel path is faster, and
should be used for speeding things up rather than a "direct path to
user space". Your comparison should have 3 numbers - current AF_XDP,
patched AF_XDP, in-kernel handling.
