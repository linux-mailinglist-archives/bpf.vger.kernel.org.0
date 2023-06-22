Return-Path: <bpf+bounces-3155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BE773A4DC
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 17:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98594281A2B
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCD91F942;
	Thu, 22 Jun 2023 15:27:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DDA1F18B
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 15:27:03 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2098.outbound.protection.outlook.com [40.107.220.98])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FF42111
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 08:26:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7Fw9ohEahiAPDIFSluPgx9Y6DETmrOCzu/xAoXNY86bCRUgqiF0+b9b1tnMQT8srWaAu+5+7wEK09TTzZF06ecFWfSK5c2Et8TJwoQ9i2n8SG+mbqBtzs0cEyxfTtlsXMekGKo7aIYlOX5hlpGEuwZv9DAsFRwyc++FO2PByIjZVdGRBbVYPgYRqGAg1IXwk1EMwmMeNgNA8NqUVotQ/Sj8EdTEFcn+G4NhqODOr0CbyYlr9YsOhhC1Muo+JAyYZTDj1HnZ3yvGAhGzzv4TFLcbFHdLA1oSOrf2lR/Bu+nKjKcLyzB30shhjvlz1+8hOxrhGg9Ea9fy9aCQ8TmZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70kKc1xYgpMtrk0sdPEkuI/iTmdSqWN05oOwU2Kc4YU=;
 b=RHHq9x/EtjklrDoqIMRQFzj+9WiV0LB1ynZbjcddKsT1RNJ3sJ2nYU247DLFsLNrf9Hs8Fz5JkUQXotCQh29KLo1OqX9Eeh2qObbzLhtCQKtvph2QLFK+FhMpIrTa8PvT8YBqDLozaHdcVOr7aROsdRjcMI1Uow9ShJbCwDk1LdWFX/2ILRPSJ48dY1ouA1jA+RzIrPzX8B8I6+JdgNLcQBkioJ0beztGimv33j8HaEor2u9AteEm9bG7noFbScy1TB+7NG4+nqdCxe/RT+tNiql39bwIglNPd0Ndue5DCGj83NEAzuP0wUg5EYvN9hsbGh2r26QVzf3hJSAkrgY8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70kKc1xYgpMtrk0sdPEkuI/iTmdSqWN05oOwU2Kc4YU=;
 b=KMNcjs/sdQOxppmNmGW/Nj1jv0ZMDe4Zx54XwB780UIdaD6QOO9L5TYbDkcG9fdIpvcxGalwFvj2JHAp9nImFv3D1xIX8iT8iCS6h18hq2idXc7yn/CeOydFxh5SbWZLKXQ2enCRK7owAWC2EZPiOSoFtzk+q6hXQTdW0Up6fiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by LV8PR13MB6518.namprd13.prod.outlook.com (2603:10b6:408:186::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.13; Thu, 22 Jun
 2023 15:26:34 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::eb8f:e482:76e0:fe6e%5]) with mapi id 15.20.6521.023; Thu, 22 Jun 2023
 15:26:34 +0000
Date: Thu, 22 Jun 2023 17:26:27 +0200
From: Simon Horman <simon.horman@corigine.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
	haoluo@google.com, jolsa@kernel.org
Subject: Re: [RFC bpf-next v2 03/11] xsk: Support XDP_TX_METADATA_LEN
Message-ID: <ZJRoI2U1WD83yz/J@corigine.com>
References: <20230621170244.1283336-1-sdf@google.com>
 <20230621170244.1283336-4-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621170244.1283336-4-sdf@google.com>
X-ClientProxiedBy: AM0PR10CA0074.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::27) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|LV8PR13MB6518:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e17a90-119a-4295-3e34-08db7335101a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	abx/IkqThW4gfAAI139LDjKuiwkuir5vZFqM/jC6GKfQbI/PlFNWx0juw/ZyIIMLr05zP98IjOLvsDB6xCQAdGGbD8AcDXDTXfhHbd/t6Omb6KDRzwKgOCFc51t7lQTl1oXlpuhwiyZ/pVu9GFoIcFFDV8PwQDzs8jGs9Shx41gtm1r4L64ZxJjBUZt02pIN/BBQgi9qwKJda0/NZKYPZ6i/wEVOIh/49SgYGa2rHC+j1lft9PY+U4KFty26YjiFlTuOB7Nu0glu+GTI+Oe6WYGBKDJDDQNTj4qnPZBBucL3JafB2+diJXbfbYzR0XpCdAMZR2I+Yp/lISFqJ2mHH5IErTIlj62osXFh6mAcqIHh0BCwRvE7/gpujfaBfZEVg+yfSCPDrwYUHuuJlawV8tgIind/PQF2l3jO4/ne9IGLDPoPVj0URyKow45i7IReHPvvrQfsyXfWQKgyWvtA2XdwfZGi2yJGnaahQvxNyMgHQzt8FlT3zY9t9sfLlduRir2IrklmdTNON/SuIwuorhfKA0c2mx/MHs5xGR2En7MyVlolehwSN0RQJcwfCUkTBzsWoSSTx8VEueaGhebRGUGvy9QK5+H2k9Z4jNrA2Hc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39840400004)(366004)(396003)(376002)(346002)(451199021)(6512007)(6506007)(36756003)(478600001)(186003)(2906002)(6486002)(6666004)(4744005)(41300700001)(316002)(83380400001)(44832011)(5660300002)(86362001)(8676002)(8936002)(38100700002)(7416002)(2616005)(66556008)(4326008)(6916009)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HMn0GMXqgcdsgmJqKnvPqH6KOi0OVRhoWEH1Y8OQUXHU4pdaF2dPiQUrNh62?=
 =?us-ascii?Q?YMH6Ez6NLoo/d97PGrk/67RmjGSBXEB9rJgkwVjDoOHpr0pG+Ofn95n99IgA?=
 =?us-ascii?Q?/GWJOqKb9g91xZWj0Pq+TpYKEPq/e2FiPP8QccOHIwqhoCCjLFcoTG9icYU9?=
 =?us-ascii?Q?XvYUNIlpmqsQzIWOVyfS3ZOZukHBSeZ90pV8YMj3R/ShG+BFYsA/ZLQS6NlP?=
 =?us-ascii?Q?ayLOEHkd9Lo0ZfGX6E1r9mp8/vF5mMKWTV5d5FE6QMi3KlWMoaUK0z9hkN+g?=
 =?us-ascii?Q?F8D0G9LNM7pQcmG2EMmenFC0rKgW+d3WPxWUDder2fwK/dHWLKwYyyYaPScd?=
 =?us-ascii?Q?mVbs0fX7Fu3tPHZqjXA3TPk5RrUxZNb5WZBYW84PLDR1GprlLoGYiFbX8b/5?=
 =?us-ascii?Q?yUmB9SlHIIjfwWkCh67JCtaMNUK/Ew4XQHE5wqt6hRbVklAYGbKlM5IvthDn?=
 =?us-ascii?Q?q/Iw16L+IQ3ekKk5NAoegCt18E3Wwn69r4ZsAQgaGgEVsTPnpxWZx0D67Q9t?=
 =?us-ascii?Q?R5zK05G8RBKgNfVdL9bFxZ/CmOvncA46emLAxOUwTW6dH3rhnWNzLkDX0Z+E?=
 =?us-ascii?Q?1iMV7G+gbtJj6Kag1VnhzQ20GcmgKK7bBHgOaSWouwc4AEgeY5ohvIt4s1gN?=
 =?us-ascii?Q?2KcFD++k97nMei1yA+htggKC2WwLM72YUgqo6E6pUpP/fTvMK5YphqOrpdaC?=
 =?us-ascii?Q?OX1tqxVbAb6KIhE5u6WiF1MqPTtlLjHM7bpOa8XqyfoanHFQ2xztL7ov8oMW?=
 =?us-ascii?Q?OfY0B3Iujp2IXMQ7zeDM5z1FflIRPdib6N3P45F9GHcTX57KSqKPLc+aVszN?=
 =?us-ascii?Q?3ED2ipFC//vING25qQ5JkEhy66+onysGLnYug5Awlju4QUaG6kept+538BQa?=
 =?us-ascii?Q?CFMKwg3FOcmCwabQ+G89mah9r+NMgdNdUPevxg0cwgBcLTurHjbmqO/5PTtt?=
 =?us-ascii?Q?sC4YqEMZOgxJMQOQZT/CGp/Ct7H4DtMrbkLlcNpqoqvlxATm0YWhD5iXsflc?=
 =?us-ascii?Q?ZRi0GzfdRrAEa9oNmpgIQTf/kmB4VpKvPwev92EKa6LPwrd8Jn5ZZS9G6we9?=
 =?us-ascii?Q?fFOAeaW32w7gUwSTU8l9lCId6nQuAub4Ym9td8nnGomVKY+9DLly8KHtHXEI?=
 =?us-ascii?Q?BKppyjK8DdfUYxf7v2hfkcvL/i+1sSODwLDVSMS6f1ZAap5ZBEgD0sEPC1NF?=
 =?us-ascii?Q?wiBQtb5XsaDr0tcPAX1dAWvGIl5CLRafE4bKUTj2P/CNkftqc/jeYrQxJzGd?=
 =?us-ascii?Q?lvswnvPzUSiNFUL4/tfD0/RHPZbS5h/eK3ZUDCGFqNIh/DMBdVoThlQNqO7X?=
 =?us-ascii?Q?sQTq8CfN0TZiGoD0om2iPg+ZTaWcH61QMjd8DPGebEmg3zSSOlYreb3Fqn2E?=
 =?us-ascii?Q?LX52x/z4fr2FYKAWGiJvdJCs262NkLmvfCymApNzLDj3xgaMJhLuj2I6N+mp?=
 =?us-ascii?Q?lK75AY38GCkS/d8ijbVotvhRNAIH9HfWHbaMIXj6ASR4ruIWwJsOHEakksFn?=
 =?us-ascii?Q?W7cHrpaQE78TccObi6o0tImeThMyCsL5NtuwWfmibGWzMTHEiRZL8VK4WW5O?=
 =?us-ascii?Q?FSCWpzIXjj2bjUgDMpoOOoCi37jNw2TBS0uagw0Bv/CBVzHlg8oaZYI/7Y8Q?=
 =?us-ascii?Q?0neOE2AmhtFFkhUS8JROzxnXhZ3MR6dyMiYplCes/6Y/JBbT5sSbwmqbrcdO?=
 =?us-ascii?Q?9mvRkw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e17a90-119a-4295-3e34-08db7335101a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 15:26:34.5669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmQ9tA97WoG7aTOC5NfbNqSMkW0zcpg6Qz1VkcN6RUkpyp6GQK5Fgcp8V4+roWfUmgxYrY9KkyYYpnLnG+Ld0PqmkjV9MroxucktwL61a70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR13MB6518
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 10:02:36AM -0700, Stanislav Fomichev wrote:

...

> @@ -1137,6 +1145,27 @@ static int xsk_setsockopt(struct socket *sock, int level, int optname,
>  		mutex_unlock(&xs->mutex);
>  		return err;
>  	}
> +	case XDP_TX_METADATA_LEN:
> +	{
> +		int val;
> +
> +		if (optlen < sizeof(val))
> +			return -EINVAL;
> +		if (copy_from_sockptr(&val, optval, sizeof(val)))
> +			return -EFAULT;
> +
> +		if (val >= 256)
> +			return -EINVAL;
> +
> +		mutex_lock(&xs->mutex);
> +		if (xs->state != XSK_READY) {
> +			mutex_unlock(&xs->mutex);
> +			return -EBUSY;
> +		}
> +		xs->tx_metadata_len = val;
> +		mutex_unlock(&xs->mutex);
> +		return err;

Hi Stan,

clang-16 complains that err is used uninitialised here.

 net/xdp/xsk.c:1167:10: warning: variable 'err' is uninitialized when used here [-Wuninitialized]
                 return err;
                        ^~~
 net/xdp/xsk.c:1065:9: note: initialize the variable 'err' to silence this warning
         int err;
                ^
                 = 0

> +	}
>  	default:
>  		break;
>  	}

...

