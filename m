Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C6E1B188A
	for <lists+bpf@lfdr.de>; Mon, 20 Apr 2020 23:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgDTVh6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Apr 2020 17:37:58 -0400
Received: from relay0245.mxlogin.com ([199.181.239.245]:45065 "EHLO
        relay0245.mxlogin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgDTVh6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Apr 2020 17:37:58 -0400
Received: from filter003.mxroute.com ([168.235.111.26] 168-235-111-26.cloud.ramnode.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by relay0245.mxlogin.com (ZoneMTA) with ESMTPSA id 1719986b27a0000766.001
 for <bpf@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Mon, 20 Apr 2020 21:37:53 +0000
X-Zone-Loop: b05d2d67735dbf039f821dac8cc1d69de028a559be8e
X-Originating-IP: [168.235.111.26]
Received: from ocean.mxroute.com (ocean.mxroute.com [195.201.59.214])
        by filter003.mxroute.com (Postfix) with ESMTPS id B026360040
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2020 21:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gflclan.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=E4ivrlw8iCtZzVS480+hGfgJ4FU/LmxsiY+z4NrNRgI=; b=gzJaSYKhIi/4HdNWzz2QqJHucj
        uiQFzCSfaCyCen+lotQ0FSWA2FhP38GHkFs6vJIiDFDIQPHAzsaJEvE5xzE11OMpqzc6uZKkzBhpx
        wNw61Bu74ByUodn+1BOO+7rR0jKDBpwDry7c1vK4bFx8sl3giwvYBIzq0F/vizsjZiLB78+dNXeWG
        +wqknJzAA9xgB329cVoCa7Bfqi4SVKUmPP4zH15GJDT2Ou1Y9BIWEw47oPuMIsSCkDiQsZM5PfFoJ
        aHxvEsCJh2Zdd6QXHxozQ5y8vqyHTlLNPL8IeqeqE23od4BSFkniL3j0M6kGZiP7rlAq+BGU7r7Y0
        /WNFNOJA==;
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From:   Christian Deacon <gamemann@gflclan.com>
Subject: Bpfilter Development
Message-ID: <ac739c9c-f377-129f-1d4b-6c4c7e15f83d@gflclan.com>
Date:   Mon, 20 Apr 2020 16:37:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-OutGoing-Spam-Status: No, score=-10.0
X-AuthUser: gamemann@gflclan.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey everyone,


I apologize if this is the incorrect place to address this. I couldn't 
find any mailing list for Bpfilter specifically. If there is a better 
place to address this, suggestions are welcomed and appreciated!


I was wondering if Bpfilter is still under development or if the project 
development is at a halt. I am planning out my next major project that 
will be responsible for forwarding traffic and blocking (D)DoS attacks 
based off of filtering rules. As of right now, I'm trying to decide 
whether to use Bpfilter or XDP-native for blocking malicious traffic. 
With the project's current layout, I feel it would be easier using 
something like Bpfilter for this. However, I'm not sure when this will 
be completely developed to the point it'd be usable with my application. 
If this project is under development, is there any ETA on when it will 
be officially supported and in a usable state for most applications 
(specifically for dropping malicious traffic)?


One last question I had is if there were any estimates on how fast 
Bpfilter would be compared to XDP-native when dropping malicious 
packets. I'd assume they would see similar performance, but I'm not 
entirely sure.


Any help is highly appreciated and thank you for your time!

