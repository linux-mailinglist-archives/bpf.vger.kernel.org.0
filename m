Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBBB3CB002
	for <lists+bpf@lfdr.de>; Fri, 16 Jul 2021 02:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhGPAIJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 20:08:09 -0400
Received: from mail-bn8nam11on2083.outbound.protection.outlook.com ([40.107.236.83]:19488
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230425AbhGPAHm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 20:07:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ab7WfYbGjVSbxE/Z1P8Fol5eaXDeuU1slj6OsxchH6S1WXakdKSYQx9HJavJZJ+/aZ6VleYAazxR93oIhAm4wYuKCvPoNSxUSdFUXQbGAcTeMH+n5d0ao6gFqpgWWkybH68jFJvoFyuqX5Q7Nc6WvHUJpZrprcmiq9TlFn5Y2oSO/nKzkoFD/T7dgJTyQZeffZJRNqJdRxlHfpOyCa75HH0hQGJvxFdB+FUyp838+NUkPIw3HOT21W0uDRikYRJ4iTcXfW7zEofVqhnbW6UyMRaYKySnie4Wwtm7crd5+D+xhDA6KLYZ8dISVbixZSLxIUTBb8IbfHupxlQGCv/Bdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Re5Bc92d6m/Rf7XezquGMbDE3PnIciLxGBjLmJegDA=;
 b=Oyb4riZp2rfj//0NN6uJ4f0XzQTXG9o47g1iPXGbINqpuNnum+5c58wVYShEMNw7XVt5EloAI4I2JGba7ECtm6wvgeKqicmWoIsYKtO3UBjzkwVLsU8rv/G/PXXCzv609jye0PX9kRveUJNAMg7cO90rahYNUrA3kEeYc8Af6QkDiDUAVuFW3hB0XB6QfAq+hjStkuH4lER5qU5fw2eVNy3Q1FOr3nAfnuw4e6tew/euO9yJECgA4gUcvehK3QEEGN5ygsdup9Z3G1cQyEvVV+kR+YohKfymHLl3BXKw5P6fucHOpng99kVwaW5Z4wrnJ1pCXj6jnEhqYO0JYqlOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Re5Bc92d6m/Rf7XezquGMbDE3PnIciLxGBjLmJegDA=;
 b=igAb36YE0oAfJfqRJB3Jqcb5BFUUkXEhR8fHpZ3EPbft249ORysBXdIo5V8LAhvl9taZdDsE33IweznrK9agzosgGu0whkEF4vE7Vhp5Yi5D0Wlh5tE8dYXs4zguDqIvUDXkF1LWD2DEVzGuZsIrz9YPNrMBwfsD8NAGz2ZaZmnf4NHFpzP2YQod9ppLDC0zpuWanZe7quxVmX3ziOe8iUeZ2Kq8ayESeLSI2bgLu+49GLrc1Qta3vAwArBrfH60v9rC/6TvhRFjwJdWFJ9XV97tio4h2Qhxe8+2Z7HQxfw8BwUyzAtg9qYIetXtKiuugs4TpC7CYBooF5YpDxfafQ==
Received: from DM6PR02CA0100.namprd02.prod.outlook.com (2603:10b6:5:1f4::41)
 by CY4PR12MB1592.namprd12.prod.outlook.com (2603:10b6:910:d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Fri, 16 Jul
 2021 00:04:44 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::95) by DM6PR02CA0100.outlook.office365.com
 (2603:10b6:5:1f4::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 00:04:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 00:04:44 +0000
Received: from [10.2.84.248] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 16 Jul
 2021 00:04:43 +0000
Subject: Re: [PATCH 4/4] Revert "mm/page_alloc: make should_fail_alloc_page()
 static"
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>, <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
CC:     <brouer@redhat.com>,
        Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        Zhang Qiang <Qiang.Zhang@windriver.com>,
        Yanfei Xu <yanfei.xu@windriver.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Matteo Croce <mcroce@microsoft.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
References: <20210713152100.10381-1-mgorman@techsingularity.net>
 <20210713152100.10381-5-mgorman@techsingularity.net>
 <fb642720-b651-e93f-4656-7042493efba8@nvidia.com>
 <5db9011e-9b52-b415-70b6-c7ee1b01436b@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <90251cd2-7c4c-9d2f-668f-c2168da7ac9c@nvidia.com>
Date:   Thu, 15 Jul 2021 17:04:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5db9011e-9b52-b415-70b6-c7ee1b01436b@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc20e589-3f3e-4954-d8f5-08d947ed5100
X-MS-TrafficTypeDiagnostic: CY4PR12MB1592:
X-Microsoft-Antispam-PRVS: <CY4PR12MB159291D7954C11661B57E9A4A8119@CY4PR12MB1592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3JBnd/XIXu3M0CeHs7CA2HMgc9KUNVjO2tTZBBJIQ5zaCPuusaLsIZcPV5+Jl5pXENm82T29Y8KGnScBqn8UCzEEGcuKZxb3V744qAL88SlZ8TtiIAMVORtgOkmJwqRinhI/OruL8GnKP/wGuxINw0P5MgUXk4jsSZVMBgUQzJErzfC73CYM2AYHC4cJPxXWA0tWsboIZv85rU6sLnmGBh4mzhqBzbFEPfUtJxQzu/YrWQIaFg3QPaICk/nkyMkvJleddhVIMTPbpnM22d7psXeKpH7aJTAC0yi6vh1pW5WuDnOjnpC3CM7fhfcLak7T+Abk9R1yNWLR0aecEanuV/35kocnxZ16vt6MhhKqlWJXiJazC/kwaHo4+Idhtvku5mEisVfrLnT3bLmezXINZH7kVrjHQI/WgR40Z5ofGxrkmpoRsAypF7EWHaoA4otsmD9omTNxXtuRayWHk0sBRuNXT0L4xMWW2JGS7ow8vRzGwK6IoCxpiGVDeLdC8WPqvydXIcP8U8NdsF0jV4yh1pf5Q0jYve6KVw05WiXulRbpO9RQqTcLC/5O9RAFLNGLJ/PKy72/sgq21YzS8AK5pC7COmmV4wHuaby62iWiGzdA4YBrS26VyalMGCaAwoFbPEbe+hMuhlZ6aNv7xvAK2cbbRU/1YBYfigjbsHe2FOEspnCtHc0UtkV6LRCISiD9oKW7rdj26IsEAWY/jlRvpWm9n5hrxRhpvNw2De7u5rkICVeMDSdp4Id7iFQdGYuZTyu6lCKEadVxoRQocTgryh5qOAGPOQh59lpyv25OcsA=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(36840700001)(46966006)(110136005)(356005)(336012)(426003)(2616005)(316002)(7416002)(82740400003)(36756003)(34020700004)(36860700001)(54906003)(478600001)(7636003)(16576012)(4326008)(31696002)(82310400003)(8676002)(8936002)(70586007)(31686004)(2906002)(36906005)(83380400001)(70206006)(5660300002)(16526019)(47076005)(186003)(26005)(86362001)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 00:04:44.0297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc20e589-3f3e-4954-d8f5-08d947ed5100
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1592
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

...
>> LD      vmlinux
>> BTFIDS  vmlinux
>> FAILED elf_update(WRITE): no error
> 
> This elf_update(WRITE) error is new to me.
> 
>> make: *** [Makefile:1176: vmlinux] Error 255
>> make: *** Deleting file 'vmlinux'
> 
> It is annoying that vmlinux is deleted in this case, because I usually give Jiri the output from 
> 'resolve_btfids -v' on vmlinux.
> 
>   $ ./tools/bpf/resolve_btfids/resolve_btfids -v vmlinux.failed
> 
> You can do:
> $ git diff
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 3b261b0f74f0..02dec10a7d75 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -302,7 +302,8 @@ cleanup()
>          rm -f .tmp_symversions.lds
>          rm -f .tmp_vmlinux*
>          rm -f System.map
> -       rm -f vmlinux
> +       # rm -f vmlinux
> +       mv vmlinux vmlinux.failed
>          rm -f vmlinux.o
>   }
> 
> 
>>
>>
>> ...and un-setting CONFIG_DEBUG_INFO_BTF makes that disappear. Maybe someone
>> who is understands the BTFIDS build step can shed some light on that; I'm
>> not there yet. :)
> 
> I'm just a user/consume of output from the BTFIDS build step, I think Jiri Olsa own the tool 
> resolve_btfids, and ACME pahole.  I've hit a number of issues in the past that Jiri and ACME help 
> resolve quickly.
> The most efficient solution I've found was to upgrade pahole to a newer version.
> 
> What version of pahole does your build system have?
> 
> What is your GCC version?
> 

Just a quick answer first on the versions: this is an up to date Arch Linux system:

gcc: 11.1.0
pahole: 1.21

I'll try to get the other step done later this evening.

thanks,
-- 
John Hubbard
NVIDIA
