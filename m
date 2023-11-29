Return-Path: <bpf+bounces-16140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 032367FD5A5
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 12:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52A9EB218B3
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 11:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309291CA8D;
	Wed, 29 Nov 2023 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="scgKz9s9"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475871BE4
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 03:28:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDE3Rnv63Pp0npMQfmvj3NZSxotHxAVxrbuAa9rLAwkLDi1w5DjTrUwjiWb2QHNWiR+WH0shRWE/t+vz3w5knEQ5UIyrAHN1M0fvC110NFTQhYePiNwmnziitsKRXrohHHMN8jPHqdR8ThVzN4O04K0G2mO8IinpTbkSd01s2HA+BD9PS5oVOAkfdq52gQQubRZ+htsX8WnmaZbrZVu7ym1t6jZOMqidE250JWdUXQr8UUpEIBUXzxchA5+HZYyIeYvPAPHsaQdI0X90VoV1D8bYb2f312oim6yHodZyEymN6CZbma8ZUI30uJJA8phVCmpWuN1ugTil+MMkZdDxow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jndjUMYTld9ixPeDCZr9SGWwEnpCUwSKuEe7ycpF/mo=;
 b=WGIsefPVcV+Stgj/AawEiiX+zwy618IN46G1pn+WagpiurkOoiQA8rExuS6/PrZLjqjOCIpmsBDSBhQoiVydjnBweCOw6i5S6Xr37AlKyQjrFRau6JhQy0ZP/0riBvVpZ3jB7fbryHN0DQ5bqb/HEf5zglJwguhTSyJgt9DzsUlamZv0wJzpR+V8UGdOLF6/8D8K483YGiY+r12SY7qDGrtgZ0cgIefoj073HBDYqhN5tnl8ujVH4UH4HJVTvizEa0cOUZjlTqS4ps72zZCxH/MaNa5QaIz9iU5OHrSko/KTLJdDoWTkM884Y0X7/6IIU+nl7LgO2OHsJ4TCli5IwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jndjUMYTld9ixPeDCZr9SGWwEnpCUwSKuEe7ycpF/mo=;
 b=scgKz9s9LcrlidMm2YSzCTMwWsrAZ5TqWfX1awryu0uaBpCIWUkh3MVk/6u0BQ9brKYH/ILrD/DV8LlXif/8+TxgeU6ASCYqphYKkFOUq1lVOa5JLuMh+xXF5Jp5v918AtALYBqo7CvBz4QgQyZE9JLt7276XLvFhZhZIARJRuryjZR9M0YHHu2X+TkQb7yCbIx/YTp3fPeK6VFTHG4mHCwxIKeYVnbXFb4L28n5WbOsOZN7UVBiYkJ52/0mh7fV2Vj0NRsafBGC3my97jN7QPp7uqnMwb31dHBD/TDg4coun1fwpwgHDcl80+9oE7g3NozVC/b9nYpMcFOtyYzdxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by DB9PR04MB9675.eurprd04.prod.outlook.com (2603:10a6:10:307::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Wed, 29 Nov
 2023 11:27:59 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%7]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 11:27:59 +0000
Date: Wed, 29 Nov 2023 19:27:50 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 bpf-next 00/10] BPF verifier retval logic fixes
Message-ID: <ip4ess62ozhdajzq4idk6w3xy76cgfgkfgq3grwpmq6u4vpead@mfzyvaiofu3d>
References: <20231129003620.1049610-1-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129003620.1049610-1-andrii@kernel.org>
X-ClientProxiedBy: TYCP286CA0232.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::18) To AS8PR04MB8660.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|DB9PR04MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a5f90f-b803-413f-b5b9-08dbf0ce3de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xLKC60QBg3GtlHV06REgl98gXYDhtRUzRRtz9eBiXlu1RcFgNOzJm+Oum7uRgypWlOD55glxiSpFcxho3p0qpujzHJnI3Ivukcb9Oa9WWV1SyNC+NoMjs+NuRoQu+iyTgWs4UVMM/WE7PQPhcXAwl8hmxgSQ6JEYvni1oigNHt2K6dLbc0Bc0hD0jhInqIo3ov90vilkd2SpVZC+NO0YcgNjzODXe8SBFZu+E9rkGAc+iIUdDylUqhnzRwol0ppRrPK1lGEXSGyTtRkDkEf0qSiT0t+dFw/fnqf9tRNxOIrcpYUSKLICagAbOYo2ltmNqC8SWsx66F1rbj4HHBkNsoD+b0mF9ixpWoH93ciINKxQIHl7/75jol1q5E3GGnVA9lqJfAOJuLMWi+eeTr9lNRg06vAoQErWrcyq69k0j/CODbWT07G+axk8cqBhXqreb7kTIj6sPWFinBvXjsq1C0m/xjxC5AYtRcDBnDE0rJsDzHUxUxuIWTX0004NefyWZLdWCYU5mH8H+ERBRkSoPdaGWzl2wgzcoWXKsg+JCnJo7qk1Bx1nvMKVcz3cHpLX5nj5gqmOFsk36pBeWuFqHN+sI04YEq1ud9MOf7qni7c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(39860400002)(346002)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6486002)(478600001)(4744005)(5660300002)(6666004)(2906002)(316002)(66476007)(6916009)(66946007)(66556008)(4326008)(8676002)(33716001)(41300700001)(8936002)(86362001)(38100700002)(6506007)(83380400001)(6512007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8dMYCfYGebCS9s9FQ0nS9c1Ktxm3mq1/Fvs05C+K2gT6n26qVCFqJJWq+/O4?=
 =?us-ascii?Q?Zt4jwTi0H3bIBEYoCtdhRhIpPNgGISs+mWyD6qKPNcVh5Tz7aAaj74gz26ja?=
 =?us-ascii?Q?DwSrgXGitziwGem4oz/tgsYtKyHgLz4mQQBt2d6uEJtDc9uM38fRrnAa+e2W?=
 =?us-ascii?Q?E5+Jr/i1lTLonE1oEp5k/hZsoxWDpNMMJfCW2oYuTi5HZuqEie5kd1fO4rvt?=
 =?us-ascii?Q?sshH+EaoluYrVuXN4ZdgTsUvjHDJ3o0KIN8bYWYUZIxByH+5vKgYxkA4onEl?=
 =?us-ascii?Q?oRSEIJXWayKFhg9m7Q7ZO9NRlL5hoZZU3tjIIGKneqr7eoCFMNN0LJa5X/AP?=
 =?us-ascii?Q?KJnBCSbt5D58QPVSQXriURRKxjzp5xXtvSq+Daz3AgJbbgXXmPYZIM1olKPX?=
 =?us-ascii?Q?Nuq0BqTzMuF8RKPKQKuVX5sP7E1WIA5nWD0tht3U7bsM7C+5VCiEhM4xAt+0?=
 =?us-ascii?Q?PhHXKSaRp7DXB15YeyXKUawSg8OBrEMfRl36U8ot/GThiNsMnoMVzZq6D0cz?=
 =?us-ascii?Q?M8AGZRA7dog91N6HOR+XFy3qkUy6+xJgdGlQCyPybmQEZJdZ4IE8jgHYq/b8?=
 =?us-ascii?Q?0vHFzGsn1bmO4bu7Wgw9/kxGTwtUjJIHW8x0i2WkO2531u+5i/9oMx87dKnU?=
 =?us-ascii?Q?oWF/biRq2ATqACwgzjYqjPAvzm953JlhOTmi7CxUPGTu6zK3Is1ktNA3/E9R?=
 =?us-ascii?Q?X9mY8TL6EkklEflWDFfKW8cmxV626yksj+XYYpzhTHubeg43OFS7DUVSDkAj?=
 =?us-ascii?Q?O0LGuJb3n3l4btdpcxze2qA07qFCJppyydsY709rfaGuWete1jlDK+RpVQIH?=
 =?us-ascii?Q?5RACg0j3IARKnllFNTFHu37/1x7iOhdCIQS42ZUxb3J8v+DBcVtoQ/GqzToO?=
 =?us-ascii?Q?6FpUhkS53GXtfCVZ373vtxd0D3JT8SXczc039tfIhxRcK8ujFcDSfr4m5qYE?=
 =?us-ascii?Q?rTyFhejQMWvrAOXZhN8u+5ko/GXDqMTTwW+dQ7CjGpJEjpSTledG4VUnjFee?=
 =?us-ascii?Q?m1T7cspiEjiA9+H6VAhVkFLywS/wI8dLhvOlURZ2GBQyGs69LgWDGLE/MKeU?=
 =?us-ascii?Q?shFLGm7d/7zQC0vKwoqVGHNqRAQ4fzM98acETwNNEfITd6vl9YxvMwKMjOai?=
 =?us-ascii?Q?fmbY4g46q3eTqqFaCDmAxeej/AuTqtRAku4DQwmRXKpfL5V8sg+TZvk/lQVL?=
 =?us-ascii?Q?cSh8QGuOW48BF8B4EpTJ6J04DD6ryajTFFVoTl6gxJ4Uo6pTK8Mz/11tUsJ9?=
 =?us-ascii?Q?LifNEhVOcfZxV4ibA3dvz2T5o1QzCvwKJcOlh7I/JVya/jT3F/fzjMV7utr+?=
 =?us-ascii?Q?RwH1h283wuhIIf1/iBG1bSifXmKCCsXrmmeoDFL9V0xiDph5oVMxAimpUuEB?=
 =?us-ascii?Q?lLh7MhWhpR02IjFCW33PWP/lXfaWKjIVWpEK0L9nTiVv0SwacyyRQzoYlK5t?=
 =?us-ascii?Q?8j8fdD7QOPBgotRlO9P54nalcsvntlGUpQYTMxo6is/Hk9d/4AyCHnIs52Gd?=
 =?us-ascii?Q?DmAVylWz5K+dVN/jczjiufhuUvJzvNJv7+nCVs2d0ENHx4m6BJo93UEECFeo?=
 =?us-ascii?Q?q/4Bj4wmD3Jk57XvuYgO7+qQcwanvSatCXFHO33/tyUom2+T7u0m/zTY3dUd?=
 =?us-ascii?Q?PhILige5ZwNLN8pTSNrjH7TMrpj1Uj8iILWm2A/8Jta/i657XPXnHvBiTS8e?=
 =?us-ascii?Q?bva34w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a5f90f-b803-413f-b5b9-08dbf0ce3de0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8660.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 11:27:59.7457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0RLGHr+zCSPXgdxxacOK3hZHFWRK9mtQ3vKFg8eSaHhye7X2sf+UbHzYehAZwA2Z9MGT0g5bq8esNCbO6lMWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9675

On Tue, Nov 28, 2023 at 04:36:10PM -0800, Andrii Nakryiko wrote:
> This patch set fixes BPF verifier logic around validating and enforcing return
> values for BPF programs that have specific range of expected return values.
> Both sync and async callbacks have similar logic and are fixes as well.
> A few tests are added that would fail without the fixes in this patch set.
> 
> Also, while at it, we update retval checking logic to use umin/umax range

Looks like this should be change to smin/smax as well

> instead of tnum, avoiding future potential issues if expected range cannot be
> represented precisely by tnum (e.g., [0, 2] is not representable by tnum and
> is treated as [0, 3]).
> 
> There is a little bit of refactoring to unify async callback and program exit
> logic to avoid duplication of checks as much as possible.
> 
> v1->v2:
>   - drop tnum from retval checks (Eduard);
>   - use smin/smax instead of umin/umax (Alexei).

...

