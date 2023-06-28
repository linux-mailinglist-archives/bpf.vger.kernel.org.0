Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982977418E1
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 21:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjF1TbH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Jun 2023 15:31:07 -0400
Received: from mail-mw2nam12on2124.outbound.protection.outlook.com ([40.107.244.124]:51009
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229469AbjF1Tah (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Jun 2023 15:30:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPSNUPjyyk5oDXTK5eY2GvvQfpghA4ZPRWdYGjJqMaPQk9bQHnk1xmHXrQF7NrK/XI/9ityOLZJjeAotNG3zHeVQWCQHL+Rysuc3EWstmgZaIvxDg2yJWotYvekJRi5UXxp5JN7UQ3EB2Rk7Og57QWwdw2IToSSCO6fMxmvkOPcwtJkhDIX29vg+VtArnoEw9qPFSX0u02XPMMfP+InhyaUZPG2bgU1w3UGYrRvs3aQWqQSwGTBK5kcRyD1bcodRU3W4HKSjQyDuPySoZKUenjnJxT2m0tBsgEc8URpTR4CR46+xxf0y5SP49WbdeZDJLO3kL2CmiB65rCl4Hgw8lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sPj/U194DFjPkfhfTKqq68OkzbsYNd9+AUa0EeNZ9Ks=;
 b=YBZ6kE8OkyEzxKfQ001O7BhrwSzHKAl1sNFR8CHcqqdlMtDvlEduu9Ct6SY/6x2V90zqstvsAmM3Zc0s6fW8y/ScPVACAX/zatVnCFdPi5Kh2FuAZUuOj9p6veC0ldZs20ePN1A/hnlAmQf4m7pxhDjBltGhtMHFYwv65MeScfuiFtl/8RCb32mmRoBuQ4pEH3tNNDK6wjsOZyccp5EpSh8e1zNSzcJsfwrdUaILCK0vpwP7EOlZs9PvbsT40PGMuid9Fgez6+49vt/J4n1fKZIhngUOc1hgkfRr6rSk80y8FTS0Ijq6CQjPrmWYN7remN8FEpf2XRt5zTSFmFybgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sPj/U194DFjPkfhfTKqq68OkzbsYNd9+AUa0EeNZ9Ks=;
 b=bRmHjfLhoKeLQYB1KUwp/q7f91q89Y4EgZaw4FBVcW8sNlM49ylHa/VKYR06Egvvl++BX7PO8mH5pgOCOKEDEGf/w0vf5MbYrbkMsYoIYW+/fvaDlHAAhTnVPDF3OoHe4spk5uVX8UZFhiKpkm2a0BEdutFPAkeyvAxY/8lF2YE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by SA0PR13MB4125.namprd13.prod.outlook.com (2603:10b6:806:73::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 19:30:31 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 19:30:31 +0000
Date:   Wed, 28 Jun 2023 21:30:23 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Vernet <void@manifault.com>,
        Hou Tao <houtao@huaweicloud.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
        rcu@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 06/13] bpf: Further refactor alloc_bulk().
Message-ID: <ZJyKTxNDPAkcEwTB@corigine.com>
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
 <20230628015634.33193-7-alexei.starovoitov@gmail.com>
 <ZJxWR9SZ5lya+MN+@corigine.com>
 <CAADnVQJcQif0ZvOeF4YD+KzR3Vp85qL=K=eyKkUvFhc4G_pgoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJcQif0ZvOeF4YD+KzR3Vp85qL=K=eyKkUvFhc4G_pgoA@mail.gmail.com>
X-ClientProxiedBy: AM0PR03CA0076.eurprd03.prod.outlook.com
 (2603:10a6:208:69::17) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|SA0PR13MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ab51bc-e2e1-440d-17a2-08db780e22c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fA9nK5S5lXmhScMCNRblxae24musEMFIyqFdhC0J6qeu8atBFELONdONqQIL9pOOpqzxG/dSFI/qSQtVJPNDknZ7O/sUOxJ9w4Wex+UIA2HQguR7E1pmh+qmAEuKvJa5PYBCzsgenqyt+ubpEDDtw9VCWrQfhsfnh2v6rw1uBJZ6WXyQCCP/lup91PRcV8fDe5eVXgQ/3pWBKa5eob6Spgz6b6qPR2D/yF3bm2CNjEChDzjBoufnGlsZ9Xccas71+6XKMfpxKWgHGe5GoySgwGNotLvyyyYaltHDbyAOMI72C7xH3nlHTfhot/48qIEfJ5hq48PbbzK1n/4xQdhU3YhI9oPVhTdZCBFDD/3jwj1Q7XgnfQgsMxXKAq5RWvkLRMJbvyhrF+QN6B4dQCp6jQv6G2W0FmR1Zgjlwcnb9w4MlNAg8sRRCOIMLFSOSvvEHRz9dePPopais+8/TcxWC9Sy4u/CDdCORryzm1UFw9wcTroEp5+Nnzqcp1jLw52Un4nOuzevUcWNow2zDoY15jVWWRTjCrb8LeIbLrfhY0WrEAZRUnq/VwzQQZKHubEG2NyhaTPN6rOj/XbAfK4N/EqSps9Sc1qu9rUSuWBMSxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(366004)(39840400004)(451199021)(38100700002)(36756003)(86362001)(478600001)(54906003)(4744005)(6666004)(6486002)(2616005)(4326008)(8936002)(41300700001)(316002)(66946007)(66556008)(66476007)(8676002)(6512007)(6506007)(186003)(53546011)(26005)(6916009)(44832011)(7416002)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUtIRFAzUVg4WTNyT2twblpEb3h4NTM3ZE82MU5XMnJSckZZakVyV09UWFRr?=
 =?utf-8?B?WVp5V2xjZ05xcHB0VjV6a3hnNXAxREFzSjljZFlqUVpGaUpXcDBxYmpYMitn?=
 =?utf-8?B?bE1lUXh6QmRCRkJNdlhhTE5tZlBDVmFUdStYRTZpRFl6dkoxMytYa3d3UUJs?=
 =?utf-8?B?Q2E4MnhNVklGYVRxRUNzd0hzSGV5YjhVRkM2aENHR0c2U1FzSTJGSzNRUkJr?=
 =?utf-8?B?aVgvMGIxUFdGUVh3TmltNUdxMVowRTJuVUxGUU5Vekphek5tWVhqb3RZOStM?=
 =?utf-8?B?TnpGRTNNS3dtYVdqS1FjMzRXeU1KMlgwSjl2d2Q4N0VmVlg5WDY0QlRBZXFD?=
 =?utf-8?B?eUluZzlKSnV5QXpzTko5cEdCeDhybjlJa3JUSzd5ZktVbkFRWjlaSGZMcVox?=
 =?utf-8?B?MUZLc0NxbE9rSC9pZ3VzSTBubXl0VEJENHVFVUV5OHNBMEh6K0g0azdRWlVU?=
 =?utf-8?B?RlAyRWFQR2t2MVV0MHM4SGdSRHp3ZGxYNHVlL2IvaU94YmpNSG5rTDVCaGFX?=
 =?utf-8?B?UDVVZVVNTGlGWGc2Q05lTFhIb0VyWUZuME5UVUk4L1VrU2huSjJpS1RzY01P?=
 =?utf-8?B?THZUOTQ3YmZnNDdMZTk4MXVBc1pWa0N5dVJTekFxZTNKNmZ6TlYvYmc3TWpx?=
 =?utf-8?B?MVpFVDRpWlJmQVZPOVVsWVdjWGdoTHJyS2crZUtLVDJwOWFwU3VSYkhpZG5E?=
 =?utf-8?B?UGd6aUZBWmxnVGVxYzdXK1dKNXZTT1lGOHdxSUg0QjRGNjZPLzdsSVl1SkVs?=
 =?utf-8?B?dkhuTENzaElwb04wTUhPRW1RUGF6bUh1SzhCWnNrZklKZnA5RGFBVEJvYjlU?=
 =?utf-8?B?aU9yMWJhL1RhWTZOdWNJRGpQRTNnT3RuNUxBWStpUS9leEhOK3R5ZUhLVWNi?=
 =?utf-8?B?MEFxVldWMWprOW02MDJocjVtcFJwd3QyOWN2bCtPeFc3T0VvdW9YNnF1a1NH?=
 =?utf-8?B?dmZZRU4yQWVTenlZckVYa014cGdqUzdadjBLZ3RDbkhpZVZFRXZMZmtIVHZo?=
 =?utf-8?B?RmROaXU4b1QrTU52bFgwVDZnbUN2MlFIT1E3ck5ROFhYeUxkM0NNQW0xbmk5?=
 =?utf-8?B?NnU5ZnJMbXJGMndxdlpIUWRibVpYcStQTWtQTEFUbTkyNmNKeGhRL1REQlR6?=
 =?utf-8?B?SXdTYUdjcXRjRWN4cFYxMU5sNWNlN2VidElWV0laTDQxcjZSakEvd3kycnEw?=
 =?utf-8?B?ckpXZURod3VJQjFzMjArVXNoK0VmaklkM09QMzlaMC9VYWNKQk5KL214V1RE?=
 =?utf-8?B?OFNDMGhQRDlTUWcrd0c2WnIvbWI4U2daT3E4WkM4VnZZMEd6WnhpQkhucUVF?=
 =?utf-8?B?bE1oU2hGYjRxQzRPdFlJNUJtWGUxeTM1Mmc4SFhXWVJVaEREa21NejUyeXd6?=
 =?utf-8?B?dnEvY1Jub0R3Y0RqajRiUTI5UU45dEFySGx2SHh3eCtUZ1Qyd1ZQRitwWS9T?=
 =?utf-8?B?Y2crekYrcmJyK0NEckpheVQ0T2F4aTVWeXUyZlhXWEtwb1YvZitnTFRGMStX?=
 =?utf-8?B?d3NLcUEySnYzKzZmVUl6dVZtUGlUYk9iVXo0Z0ZHSlQyalVHODZFeW16U2tN?=
 =?utf-8?B?VWZvclR2eEIvdGVIalcxcEJiYURvUGx4eTNJRU9ERDBhVFprZVdpb1ZJOUx6?=
 =?utf-8?B?ZTlnMXJKV0JvVHpraW5JWCtzS3N1OGR4ZFBJYmozNmtTV3RaNElETm9oL2hN?=
 =?utf-8?B?SElRVklzeE5kMTRMaTJCTHBsNkVyTnhzREFQaHdtWWduQkVjNGg0V3ZXbEt1?=
 =?utf-8?B?a2xWdW9lVjMxS0VVbzlsMW5KbUhEY0trN0poMC9ub05SY1pQS3U4Y0xaclRX?=
 =?utf-8?B?ckdSaldSNmdJL081RXUxdGhoa0ErdXd5TnJ3d3huQlpTaTVhQ1dQbXRLZ21a?=
 =?utf-8?B?TzRoRXZyaGRFNGdCaDZwdHZTSzZaNFR1Y2VEL04yZXhrbWlTUG5yd0FQak43?=
 =?utf-8?B?TVgxYjgzRlpPNllDMHpjZklwQnk5Q254VWdabU1PQUNEWnpRTUQ0RWI0NVlh?=
 =?utf-8?B?cmNXeFpCamYxVDkveHN5endWdE1mL3hVMWYyQ1JvZUtteTlMdXJqMVV3ZWJM?=
 =?utf-8?B?eVAxVzRHdmlndUdtTEVSSCtxSnlZZmJ4cGozd3ZrYzZ3N0V4NWV6eWliVmJ5?=
 =?utf-8?B?dmQ0Mll1QU4wZVY5NHpVbHRVMzBkNTlmS2RTaFpUT3ErdXZmTDNNVVhydDJF?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ab51bc-e2e1-440d-17a2-08db780e22c6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 19:30:31.3306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+34rjPTsYaUIMCxcOh6NKcdBFef9gRMxkOhjg+MSTP8yJZXn+ifSlo3pvDNlTWmsvDJLAFlA+KLXUkX68f0sqtuEbItYMWF19IgfVE4DcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR13MB4125
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 28, 2023 at 11:58:23AM -0700, Alexei Starovoitov wrote:
> On Wed, Jun 28, 2023 at 8:48 AM Simon Horman <simon.horman@corigine.com> wrote:
> >
> > On Tue, Jun 27, 2023 at 06:56:27PM -0700, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > In certain scenarios alloc_bulk() migth be taking free objects mainly from
> >
> > Hi Alexi,
> >
> > checkpatch --codespell flags: 'migth' -> 'might'
> > It also flags some typos in several other patches in this series.
> > But it seems silly to flag them individually. So I'll leave this topic here.
> 
> Thanks for flagging.
> Did you find this manually? bpf/netdev CI doesn't report such things.

Hi Alexei,

I found this outside of bpf/netdev CI.
Perhaps we (I?) should work on enabling it there?
