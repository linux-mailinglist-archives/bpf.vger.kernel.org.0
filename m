Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DF93CB22F
	for <lists+bpf@lfdr.de>; Fri, 16 Jul 2021 08:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhGPGHI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Jul 2021 02:07:08 -0400
Received: from mail-dm6nam12on2075.outbound.protection.outlook.com ([40.107.243.75]:27744
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230088AbhGPGHI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Jul 2021 02:07:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNgrjQZ/9Ss7qB3J99+QFVRbswRSEe8hG254N9Y0ug8hv+oml4fgYMdRMmzg6WwrqQX8kLh2ZHN/lrPEi+tS71YcAE39CskTiDKoYrQ4UEWL1ny983NUfRiwQVXTR438C0BZ0uDsOWmf8k48KiO6EWoF/2IcRANotCEbMWnw7CWRvh8xVaFvUXH8Gv2rkbMFQxfsPHg/z1cT1sqvKbC7h3wHBHfOZ6AIwc6GWKpSCeTY1kMP+FbTB6Qd9joRN3YTZBMwuinNUVgb5b+WY7jcPb03s8bVBS6m4Ys92w2We+CoipaQbs9r/x4hKoqkx+x2I79fmJPYxzKVDjtJX6ZS7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLhktzHBfsCaCAPy8z6BkHfGkInqBBpIaQglocH47+o=;
 b=gU1csZ2MwcsmSVr4RLmANDpXfyNBhNVWNiSHJVdkIAv6wtj+1NvNjfi7sZ/fNoXwx+pPH5hyHDBViynioqS4a0dfvrpdaPIUWod1fr1raBGkynuGNQ310l72Wd0M3oPkQ7OzXGG9pns6BYEZeIVQd9WmK4BHkj+G7PgTeTdHp3l2Yd4hJGFgGSeX8Wpcok/hZoL7DPI9SLwwySnizRBaHDwCaIWY4FqDCYWoq/tEjjYGVoZn/lfHscKESJOtzBSEumk/KFLOHZ5ofYyoLNIkSyLzvimJbjDqL2kXxQ6li7Hb/J+o33YDz+HQYfXlHw4NK6XIehK6pG2eRQJNwVYvyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLhktzHBfsCaCAPy8z6BkHfGkInqBBpIaQglocH47+o=;
 b=P9i0q7YGV7BKeSNUERnp7n13bLUrZYVoqUC4mpgzjNbfIPrtO/swMjBLHVn6UgzAZNkd/rkzQekqw9Dx5WNHwUr8Fo+2nHogvYiWOaIRV6SdwaUnuANVfnJfGq4zHQBXuthaLTRJ6VZHHLp3GmQm/9uW/WJp2T9xOsI5ClgmGbZ7MjjfII8j92gGvuXfaGjC0tDht7u7Hi9ZYzEC/35lMR7VhiX8nnYxpEAFvYz3aIjUoky3IXhDTJ15kM5Mrl0tXbVspY0A04U0qz0iKM6lT9W+G2DmyrV3SCv36eLyCByH+8pZ+ve13huoZqgpeIXXTZxpJ1j8g/PbUnmbsKgHRA==
Received: from BN6PR22CA0030.namprd22.prod.outlook.com (2603:10b6:404:37::16)
 by DM4PR12MB5342.namprd12.prod.outlook.com (2603:10b6:5:39f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Fri, 16 Jul
 2021 06:04:13 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::8d) by BN6PR22CA0030.outlook.office365.com
 (2603:10b6:404:37::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Fri, 16 Jul 2021 06:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 06:04:12 +0000
Received: from [10.2.84.248] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 16 Jul
 2021 06:04:11 +0000
Subject: Re: [PATCH 4/4] Revert "mm/page_alloc: make should_fail_alloc_page()
 static"
From:   John Hubbard <jhubbard@nvidia.com>
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
 <90251cd2-7c4c-9d2f-668f-c2168da7ac9c@nvidia.com>
Message-ID: <75085fb8-83ae-0f18-af51-df43b5f1a77c@nvidia.com>
Date:   Thu, 15 Jul 2021 23:04:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <90251cd2-7c4c-9d2f-668f-c2168da7ac9c@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c828cfd-1f86-43dd-087f-08d9481f88eb
X-MS-TrafficTypeDiagnostic: DM4PR12MB5342:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5342EA855998A372A9E8F7D0A8119@DM4PR12MB5342.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UsGKDrftDV12GHNxCrmMt9IXz/Q+y2PrcIO38xqiwQQeCphNeXuMooEY98Jpvy2FACQ6a+PW7aIdwqGFNf4wcAEy6d4L75UXyzTLF208YRjv7u6Vkcgxrq9TJDaCt0/qVj7b/vWGmJoUUL9nOgJ1rviOISrEcgKglYfGoUgADkOtmFKH88S6+pALqRQ8xixlHPgQvUht/hxVMhP5pzKPU4StzBjswaUJk94mugNzCJu7dNXgRaPlRP2Z8xaA/um0SOwYwOUk1evMkqEkutYs2jJBF9SHebprQBC1/amEu2AOIZ3XjUzGDS2N2f4M7dfOgNSPt3TAjckNqM6PovQjuspzdFPHGvfO8g86qhvEfOQKt+fYmwK3XUvRHG+sF4jVgpDI+ooGOOltmw5PFNfA34w5U/h9WY37g7GltazUA1OtVmBzySqlrnnJRz8Nwnm9Xkx8Ew6SHRlP3GZ/jLM2etVE6xTOpbxKvUuE8HQp3eWM0Wyh2ACs7FpqzwKsJDgv5dEnwPUbrn3PVAupCCoQN1Z5JobJN7SY8BXbsICrMFv7yiyy79t+KvIwcY+PPv+0l4eQhz8XJKq+A7+C9J7jjfDHlxAHahpwhovXDfe6rTtKGh/lZEv4Saq5hB0xZ2atu+zQceBkmIw0gXPlvbtq0CX/yR91mf4sdHyBpRC5NT09l7OwGt5QFSRHjs9O2iAkHND42fWw9HhR41PdvYrI9W90f/ecAu/Cgb2IpTR/hE22Y8VvCIZxOnKGWeZuS1oRlU1wleY1oSnuPaW9yC2NI6Q5mMGbUcGz7Wi8J7Eie0M=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966006)(36840700001)(47076005)(86362001)(8936002)(186003)(16526019)(54906003)(478600001)(5660300002)(70206006)(70586007)(26005)(8676002)(16576012)(36906005)(7416002)(2906002)(110136005)(356005)(36756003)(336012)(2616005)(426003)(4326008)(7636003)(83380400001)(82740400003)(36860700001)(316002)(31686004)(31696002)(82310400003)(53546011)(34020700004)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 06:04:12.6207
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c828cfd-1f86-43dd-087f-08d9481f88eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5342
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/15/21 5:04 PM, John Hubbard wrote:
...
>>> ...and un-setting CONFIG_DEBUG_INFO_BTF makes that disappear. Maybe someone
>>> who is understands the BTFIDS build step can shed some light on that; I'm
>>> not there yet. :)
>>
>> I'm just a user/consume of output from the BTFIDS build step, I think Jiri Olsa own the tool 
>> resolve_btfids, and ACME pahole.  I've hit a number of issues in the past that Jiri and ACME help 
>> resolve quickly.
>> The most efficient solution I've found was to upgrade pahole to a newer version.
>>
>> What version of pahole does your build system have?
>>
>> What is your GCC version?
>>
> 
> Just a quick answer first on the versions: this is an up to date Arch Linux system:
> 
> gcc: 11.1.0
> pahole: 1.21
> 
> I'll try to get the other step done later this evening.

...and...I've lost the repro completely. The only thing I changed was that I
attempted to update pahole. This caused Arch Linux reinstall pahole, claiming
that 1.21 is already the current version.

It acts as if there was something wrong with the pahole installation. This
seems unlikely, given that the system is merely on a routine update schedule.
However, that's the data I have.

If it ever comes up again I'll be able to run resolve_btfids, using your
steps here, so thanks for posting those!


thanks,
-- 
John Hubbard
NVIDIA
