Return-Path: <bpf+bounces-12640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB7D7CEDE9
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 04:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47E76B20DD9
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 02:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FA481E;
	Thu, 19 Oct 2023 02:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="chGgDd65"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2878B656;
	Thu, 19 Oct 2023 02:17:57 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2107.outbound.protection.outlook.com [40.107.255.107])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3133210F;
	Wed, 18 Oct 2023 19:17:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHXi46BxgG2HPSeWNT3QW4xY9VnPd5YSTJJ0RtWfDyXe0YK13+uk4XjTyZr00No4Q7g0A4CcQrXP558ZAHSor/wjFd+3zUE1A4YsK0iSuFT7Spcl+6w1ZE2M40KfkXvYc/OLbwdEiF6s1cNJkBD27iedgus/hbp2sUbBc5lkOS2wGK0BDroJbRyTxa6WdoCAAzWdUJReeJBkmz9Ezecl78foQNH0tyFB9vyFcavoqEU+rmLnLmfnkgJaZ3CX2V+TrFbqnga5/9KnJ2anwYmmqgLDO3HFKLkT+U0JJPJMZfbiQwUYmAoM52kBLnBh0GSrKdP79oWIlN38hawXhunpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5ZiWQcp6p79w4dG4f1+S47BjxSG2pLGFySn3Ey4Ytw=;
 b=aPB2cQEtCyg512V/e4z6t1Tcm5ACleCBEjxG0kgyJf6XGOxLV47G2i2N8VdBapHnAHk4wK5aTMMh2UuMqvR3yLzyrsWRJUPunqAnmGBZI/TYuBM9g3gDbCr71Ui1ghNNRT2a+C+p2h+UtfTlWsNby8qx6xoHq1YVd1iuwBwEeVsRTYMPMzlaxeQw5DRMZCMD8hvioKGJUqhI57hgpp59Y1NsjmnKtMjbLk7hsfPlT1smGP66mtfPh/MDok+NhyGh0VtNXTRAxG3JA1X52RT/T4Z4hUdzErunR1O5gLESiZRec0yu8pzBTrRJFo8kteOfiVyEM4kgV6wHuH8qkAJFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5ZiWQcp6p79w4dG4f1+S47BjxSG2pLGFySn3Ey4Ytw=;
 b=chGgDd65NzCit+uyvpH6+9bFHLxcvsgJMaizKhcfqiAolr1co/BRY0P0mCMPOSNOEnanBsBXt6yaPzMoEtIu01k2X2HndZKnGw0qKGBKWjx6igNgv86u/yIymF2HrvDtEWyQ/Rwj2BtKsDJkTL74VM2Xg9LqqZLmUsDFyiIs3Ak8RvaHNAFd6lqRJ5oQ2KQRF3269QGvRt36sRc53HtTbbkIlW0hlb9Wonvcv3wSlupVwjfGVaZDOksLZhBANnEnWrxfHUzm1SFEytaBe3ui24EQTAymMWnEYX46dSyTTkCqieKelSAQbyqfQ5J7IHWz+ozMrFxeBC6PsMcKJzfYPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by KL1PR0601MB5551.apcprd06.prod.outlook.com (2603:1096:820:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 02:17:48 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::40ac:5701:4617:f503%4]) with mapi id 15.20.6907.021; Thu, 19 Oct 2023
 02:17:48 +0000
Message-ID: <a2373558-920a-49b1-91ac-9b0a6a1468b2@vivo.com>
Date: Thu, 19 Oct 2023 10:17:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: multi-gen lru: fix stat count
To: Yu Zhao <yuzhao@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, bpf@vger.kernel.org, opensource.kernel@vivo.com
References: <20231018082104.3918770-1-link@vivo.com>
 <20231018082104.3918770-3-link@vivo.com>
 <CAOUHufbPiAhpvHuo=oH7Zhyoc0hR-6kpVrCEe-b0OuWYWne2=A@mail.gmail.com>
From: Huan Yang <link@vivo.com>
In-Reply-To: <CAOUHufbPiAhpvHuo=oH7Zhyoc0hR-6kpVrCEe-b0OuWYWne2=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0196.apcprd04.prod.outlook.com
 (2603:1096:4:14::34) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|KL1PR0601MB5551:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d0e354-7563-4641-8e92-08dbd0499693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U9iKIOXhUEQq0miq2sSBknYD3BZMkSO321kuLcgQUUGte/iMyvnwhj3j22nPM6T9cTL1667OROplywZJSfH5Bxi2KXUFFS0CSznV5aI6gfGRJge8aKJvFGPX/keAhdN9uBpR8Y+vQ8PH+E/WN/mVFPtsw4NLGrDZOTToRM9dZuIq+hvDLuCbVzG/yLrjT8YnjhJAPm3f8QMGAy5PwDvl7jQlmMuhuLul8EdRULps0a3MH9gBF6pZbXeSSCtHWQeWEVimbIb8wvCJLseJBYDhalsGHfSPGth2JWZoCG3D5AtRIZXevlO29EUdCyIaSm/U2bZXI+/9vtb/n8+3TdOnbv3GSLfDPpohc8US6g0yOs+bPk6LTzclXGkGSxB/s1qIoGZR6Hl8oT9j4PxosnbZCRcFRIEC5KEdDr/XrWDcxnS+SQIDgdJ2OVykyZL8i5q2tTTVr+Pdsq8U+XS7x6cWlVU8auimcf/+2lmLnJF4rPNBL1g7ZxH5dktDXWk8jSoavin/agZ47DVR8gAUIGg8auZZRBpBp03fGy7Ctek3BWvFK708dcywZtzUI9AdVQo4Uuk8iQps8RrEhNdsxfoY2Sy/DHKqP05KwBdhVBFYDwdoArKHeowcVlb2cLjywVKsNt2PsNRlaneDItERwrJXCa0LkW4x+pccM4ff3HoW1zqRh7cosfInFc10+UPVOD/x
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38100700002)(478600001)(6486002)(6512007)(6506007)(6666004)(53546011)(52116002)(316002)(6916009)(66946007)(54906003)(66556008)(41300700001)(66476007)(5660300002)(8936002)(8676002)(4326008)(7416002)(2906002)(2616005)(26005)(107886003)(86362001)(38350700005)(36756003)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djNnQlFMcUlFSjcreDlGbUdjTzBmTWlxbUxVaU0yc0tJWkVmWkNRZFlUeTJV?=
 =?utf-8?B?QStOeEw1a2hicjBCdHdGNzRNMHAzSm1ETFpWSm9QRHJJcDdYTVZWbldBUDM1?=
 =?utf-8?B?L3BXN0w5cVlTaUsxbHc0NC9vSzhDWG9JZE9pUDhoZitodkpBa2xKSVM4b0Yr?=
 =?utf-8?B?anlQbU1qbDBuVDZ5NWVOSDJkaGJ2MVlvcTQ1ZERKamtiVUduVGpYRUZnN1N1?=
 =?utf-8?B?clNZck5YaFh1OUlMdGh4TXFzVHd1bkhFMGhyMTB0cmhPaVU2ZFRNVWZDY1lw?=
 =?utf-8?B?dW0xUzRkYTl1dkNMVXRZU3kzTEdjTlc0WUdKSkp4aFRxN1V1K1dNOWhOL1N2?=
 =?utf-8?B?TkxMZzE1YzN5bHlrUnVUNE1qSy9kS3ViSUdpZHNiTVlJbGhxSDRSOGhFRU5E?=
 =?utf-8?B?eVJRV3JJdWJjeENrODhKQlhyV2RHMStySFZlMmdLUzNuc3NjOWV3TVdnL3Ri?=
 =?utf-8?B?aW9zck50Mk9CUjBobzllMGNEc252SE13UjN2aVpmeVJibE5VUG1EUWxYOHZx?=
 =?utf-8?B?L01QajZLdlJNc1hFelZ2M2FjeElEL3FEYnMwRzNOelM1L1NIRUZ2SGZmNVRo?=
 =?utf-8?B?VW5xWmtDUno4dzVpSUs3OTV0LzFBNElVTnoxZ0FnSXhlVHVTeU4vckZIbFJG?=
 =?utf-8?B?R3ZJcXNtL0lHN01KaFlLVXRJKy9rRmdVUlJDU29Ob0RQWktweHN4RkFvdW8x?=
 =?utf-8?B?Z3dJdmpSbWNLRWhScVFPVGxKZXRaRk00SmpsWU80dk1qQzNSTms5WEpIV2dm?=
 =?utf-8?B?aG43c1FVbGNXNXNxa0xoakZtdGoyTUc2ZnNTSjlrTEhseWVsWWZkYVZZV0Fk?=
 =?utf-8?B?TGhGZGZFZWFHb2Y3MW45aHU2aXR2bEs1R1VJRVFWbUJxOVRITm00RE1XdTFi?=
 =?utf-8?B?N3RERi9ESmFiK3c3TTdvbEljU2paREhZU2NrMFIxTE1vdkpzaFpFZ3piK055?=
 =?utf-8?B?T0NtV0lmKzlmTC9sUG9ORUM4eFVsME1KL0dmU1p6TldkSGNOd1YvcTRjbmg0?=
 =?utf-8?B?U013Ymg4eldzQlFEWmNDakswOUpVYm5Rd1g3aVBjSUk0MUp3WE90aVBieWpp?=
 =?utf-8?B?NjdqTlIybTRjc2l0Q0EwNGJ0OXFXdnVGRkRrQXNXYmhWbXhiMmx4cXVBZ3Yx?=
 =?utf-8?B?bkdnSVI1QlhnUmpRQm9TMXgycEFuZkQyQ09QY2ZuUHQwcXI2UjRPVUlob2xV?=
 =?utf-8?B?NS9mLzcrTmlkeUJrS05nUEcxN3pnUGUyeldrM0xzdmRsUWpPWmRyLytkUzdX?=
 =?utf-8?B?czJmRElQOUxYR2M2aXZ0ZngyaHJSc0NzTW5ZYWFuVEtDS1lCSktCZEJzQUVz?=
 =?utf-8?B?c3lwWFBMVFk2UjZ0ZkFtdXAxeVlGOWw0TzZBUWdKZndTVE5Wam4vRktIbjEv?=
 =?utf-8?B?bkJDWjRRRDc4M1Nac2VlUWF2MFV4dVBjODZkeDVqMkVNL0tNUG8rdFRRY0pG?=
 =?utf-8?B?bTNVZlEyODFIL2FVM1ZVM3ZWWDdNL3lrcGZ2YmNzN0ZHUU1YZ0hLQjNUenFy?=
 =?utf-8?B?Z0xJbERiNUx1djZuREl5cTFvdUExK0RMd2l2bk0zRUF2M0tKWU16UW1RY2Fw?=
 =?utf-8?B?Y0ZhbFQrQkxXQ0szUnNNOWJLbjNlUnIxbjNUUWRzVGlsUEQxaDU3cE5JeG1s?=
 =?utf-8?B?VHI4THZNZ3h2dUl1OVBLbFVmYVlOVXIwV0lGWURWcFZ6UUNRNytka0pyaVN5?=
 =?utf-8?B?WlZOdDlmRjNJTTY0M25KSGk5REJIV3JTRlU5NmxxUnNiV0R0MjJGWTBGZk5x?=
 =?utf-8?B?MCtvbFlGTXQyV3RhR2JnM1dYaGNwdkF0YXZ2dEJSYU0wSStYdVNlRXNiTnZX?=
 =?utf-8?B?U0kvZnAzSk8yLzVRSFhLcHpZR0VZR1hXRTliVUtUeThQUWF6S3gram5Hc25k?=
 =?utf-8?B?QXZ3WXh2QUZOT3daOGFWdFZtbkdnNXB4dmFqWVRSemVGZndSM2Q2MFU3d3Rt?=
 =?utf-8?B?WEZyVm0wampFTkZTd3pmUTBUTzJLUkRBMGlDcVFGbmJ1NllhRUwzOHZGSHJD?=
 =?utf-8?B?N3Rud0VFcDByWlFwbXR1VzRKS01WWnhJYXdDWGliZ1NMVEQxREcrbnI0cjFP?=
 =?utf-8?B?YVBUb3ZQTnpiMk5GbSt1SkxRdm9NTVRnZjlNMytxb1BJS3FnUVBFOWRpQ1pJ?=
 =?utf-8?Q?XHCpiElD1Z0oDJbxz4sB/uv6j?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d0e354-7563-4641-8e92-08dbd0499693
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:17:48.2958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3/bFoOZXCMpiVPio3KHTa8SgY0Szcb4kZ2mVVYiYt43wbcTWf6Xp+s5lUL/FQhyzEZGTOU58qhrBWWERzhsZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5551

Hi Yu Zhao,

Thanks for your reply.

在 2023/10/19 0:21, Yu Zhao 写道:
> On Wed, Oct 18, 2023 at 2:22 AM Huan Yang <link@vivo.com> wrote:
>> For multi-gen lru reclaim in evict_folios, like shrink_inactive_list,
>> gather folios which isolate to reclaim, and invoke shirnk_folio_list.
>>
>> But, when complete shrink, it not gather shrink reclaim stat into sc,
>> we can't get info like nr_dirty\congested in reclaim, and then
>> control writeback, dirty number and mark as LRUVEC_CONGESTED, or
>> just bpf trace shrink and get correct sc stat.
>>
>> This patch fix this by simple copy code from shrink_inactive_list when
>> end of shrink list.
> MGLRU doesn't try to write back dirt file pages in the reclaim path --
> it filters them out in sort_folio() and leaves them to the page
Nice to know this,  sort_folio() filters some folio indeed.
But, I want to know, if we touch some folio in shrink_folio_list(), may some
folio become dirty or writeback even if sort_folio() filter then?
> writeback. (The page writeback is a dedicated component for this
> purpose). So there is nothing to fix.

