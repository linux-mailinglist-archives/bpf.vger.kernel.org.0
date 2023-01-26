Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9579667CD58
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 15:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjAZON1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 09:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjAZON0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 09:13:26 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759A97EE7
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 06:13:25 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QDieCZ007827;
        Thu, 26 Jan 2023 14:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uBmc8moGoTOFJZMSDdf7fPsQJUqb6xKf+giKrgmFuXc=;
 b=pBt30iOQ6dLCCylhwsqAec3cxx+3/qVF2y7bHbIigPOHwG/JfnyQ0f2RJ0UZa51JAnas
 6JtiEKlYkNR3PiA1mIqbXWtTL0+96xRATWQAY6f3qyV5BrEWxWNRvAIRrMInLMXoLDSC
 pEoq7t8/jP3hGLQIBXMqgAbmx5H0bq9kLAYAyEQ+aBkIMaPgkNQ01bHEEqoqIsCE526M
 +qmnuIsYTKDul6wrqVwTG4nbkyqoGFAyL6u98RamuLy/HmeFQS3SNLn9vfTnQva/8+nT
 UdjO4G31dxMzZDhRsbbeq4vYvULJ4O9T/QaCBHj+rQNwXAcwfTNpWOKFAvH1kqCl1tXW xQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n87ntabts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 14:13:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30QD2gCS031778;
        Thu, 26 Jan 2023 14:13:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g7vujy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 14:13:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHxFpo4Yhkl1MA9VvOxwKp1S6uIRrKinlYS0QHuI0d/czGtjQJYG/wXCLzdApSWN1TGQVcyw0OYxf3S/o95DyKaNt4UMhLxGGk6XNojt99x8RCpCPRjbr76R4n4cQPeWx9OcO1Tg3m05maJX962wdB33hfFQgDapZS+/6VCyBcGmr2a+WLqy5U1Nik22ZkTBzJ/kzrAhzzXDmt/33CRFhlNby68B0moidsFqt+q2jHmqOZxkuFiFSdMJifP+3AO9/biDcHYFpWbPJ8Wv9O2XzZVSlw2vh5+VPNtfdgehO5xiB/GrtY1JH+csebxlfB+e/plDnYNkFxrvknILdH9HHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBmc8moGoTOFJZMSDdf7fPsQJUqb6xKf+giKrgmFuXc=;
 b=eA0N07F41H0idhq/rCB5EkaENMidNIpX9PUTg6vnnUc+ewnctOYWYj+avNvvn/H8Kup+DEuawPy9rF3/lgSB5YcjkG6zlOtlaEgXQzusQjj2S2Qi2LPNw6U1hHiolCFfTLDA0Ej6uNx1TtQBqLIWknM0GpA88rGROWO9o+A3Opb1ZWOZ5ArAcDykgh/fDl+coU2YMDNS5/F1kKctRbn9MTf2d6f0N3PxQEIWNErJRxjWRAe7yiSoy6/z80qPl8xYnil+fBfzHd00s1aJuXaCeHvVSxPM5WzoqWEam85CclCHZR1zDr9dCfwaTvYeihL2noeGrAgzZ+yny4fIzLeg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBmc8moGoTOFJZMSDdf7fPsQJUqb6xKf+giKrgmFuXc=;
 b=zamRpAR7NebaYBGei1H3l3ylmkkI0cErwVrSq4vddAXyuSGWdqWM4qu6AVv0yGyfpSbZaU6QJKLGR5soXhI39AQvaGGIDHiFtvU69A0IKMhC0GkCKe6aRw4Iy/fiBVFySbhGLZFc7i0PzwPY8iEOvm1rvvtBha9AJ4j+TZUSWtw=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CO6PR10MB5570.namprd10.prod.outlook.com (2603:10b6:303:145::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.17; Thu, 26 Jan
 2023 14:13:01 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%5]) with mapi id 15.20.6043.022; Thu, 26 Jan 2023
 14:13:01 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH dwarves 5/5] btf_encoder: skip BTF encoding of static
 functions with inconsistent prototypes
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     acme@kernel.org, yhs@fb.com, ast@kernel.org, timo@incline.eu,
        daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
 <1674567931-26458-6-git-send-email-alan.maguire@oracle.com>
 <Y9Fei36sE/59xbVn@krava>
Message-ID: <e612ddf8-3769-8f3d-835b-85e4e48dcc93@oracle.com>
Date:   Thu, 26 Jan 2023 14:12:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <Y9Fei36sE/59xbVn@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0652.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::13) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CO6PR10MB5570:EE_
X-MS-Office365-Filtering-Correlation-Id: e9847b45-33c2-4bc9-02f9-08daffa76ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnI6aHrXHExsMzDso1bPpHeMPnzy2dGQEQ1ZA5ygnIGMic4H7PUupZdRzP6zIGN0+ZHzJFR+mlZtYSYgaZQenS31r3mquwK6UE2LdAwkgH5OrcPRC/eT8Ji6ZItC/e2y9fGK8FO0h43qr9s33bdYImO+9JxCilCussqGTL+vaR0m8AGOlJOP58w8oHfpwy0P/XjHJCNugjVBGJlYYt84vVXK/gPq/66HwrGzsFdeW6QR6ZYEa0IqsVARGIbq+InCBke1GQj7B8EzRrfDMwEBeOrSLOE9gcozvywVLUy0CASyLU9aFt0LekrwDaMTU8++gfGtWfJv17iU0C8UodQTGDrzaFe1D0DJq/CwLa+FW1+HeVvtGHJddmvubGcZBJpXKUq/xJDyneZSGSbijJwVLZu4Ew3PhvVYoo72Wrv+G+GuDCj8hSosY03Y2oBBVomcGg5ozspmzgOWCJ9IXg7k9lIcMI5+5APx6+pQJK82dKQe2idO0HWLSFYGTrWnraUXU9Rh524f+64BtYOPTX9+DlRGA0VTUT7Il5bxAu6TOxd4XJFqsyJjwYce8LLx4np4jDWQZCTdNM5H/N3rO+LTnJzhXzbwfOuQ0uJY7Gmi2mxPsenbi1fVW/XFwCGfZeT8/c58dtBWbu59/5VE27ubPQhydAwEZErJd9aYjXKeQ9r+lzHCdpI8FFrWd8AfZvPoJxlFVCARcC+z9ZYuqiOpoVJoTK+nblh8UETw369xHuM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199018)(478600001)(8936002)(66946007)(5660300002)(44832011)(6512007)(38100700002)(6666004)(7416002)(83380400001)(2616005)(66556008)(53546011)(6506007)(186003)(6486002)(4326008)(86362001)(6916009)(66476007)(31696002)(41300700001)(31686004)(2906002)(8676002)(36756003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTdNSG1WZmpSa1FlY0pFY2hUWlZERlpTSzc3WWF2MmJVNXd5UTlXSjVyTWR0?=
 =?utf-8?B?NVE3Tk1KOXR1ZG50cFZ3Y3Z5WlVOejI3UnRveW9Ld1ZkeW5mQ0pPUWRncHAw?=
 =?utf-8?B?bWlLSTlLTGNLdHdpSGxLZGNTeFhTM0NFWmJHR3JsM2F3dlI4bUJSMlRsSjdY?=
 =?utf-8?B?R2g1VEVzNVhSdW9KZG5seXBOOWF4V1Zad0ozWFRlSjYxdWNyU1JMTnZOai9l?=
 =?utf-8?B?S1Q3V3VMaktKS2JJWnVLemNadmtENlpmV3lsWmhUOUJ5bS9ZU2hGMUxQUFZG?=
 =?utf-8?B?eG5tMDlpUW1VOUZYbmE3NUt1T0V4dFZHUk43ZnRVa3JWWEZJcmFzaVluVnBJ?=
 =?utf-8?B?SDhEK0VpNVlBcklORllsNWFRa1Y4TkpmNW5LY1dCdkhsdkExaFpRNU5kY2JV?=
 =?utf-8?B?MFBEbXVWbWxUMXdtLzFpMENVU2RYSjlQVllJbUlrYWhTTXB1TCtzcVcxS3pi?=
 =?utf-8?B?MzVETGNURGw4MUFJWnNzUERiWFhOL2g3aEcvWTRTREt6MVUrWXZuKzJ1U2Zm?=
 =?utf-8?B?Q1FvMGVPaHdndTdaamY3eUZjT0d1R1pGb3hmRWdySzhnQ0djd1pSdGpzUDFp?=
 =?utf-8?B?V09UaThFcjlQUm95Q21QM2k3Y3ZBTFZDVWNFdU1sQTA4Nm9IU0t3L2pnZjh6?=
 =?utf-8?B?cWxkTlFXU1ovU041ekJYMCtQMXdPQ0dJdTRjU2hDTnEwVUY0aEs3NjZIZUs1?=
 =?utf-8?B?SjNhWlA1c0c4VGgzeWFqc3JsRVpXb0d1dG9HS3h1RjJjTXphQklKVC9uRHM0?=
 =?utf-8?B?eEx6Q0dIT1ZaL1dtQ0ZoMHlyK2NodllSalRob3c5OWVQQ0V4K1F4RnM0OXJG?=
 =?utf-8?B?b0Q1VmJVaStDVkpoeTBldkkwdEwrQkNwZ01qdytya2hFaGF3YTFVd3hNeGNm?=
 =?utf-8?B?bnRJbTdMY1hPMm84ZVgzam1OU3UyaWMvUStlMWpFbjF3L0hLaXZRMnJvNnhH?=
 =?utf-8?B?NDk2OUNVS0xDV3Y2czRhNFNsMXowK0xMUlg1VUMyQ2UrTnFsSmZIMnNIVEI1?=
 =?utf-8?B?S1lqYUZ4TUxEcjZjK2dVa05ZemNWRytrcGxRMktCb1UwckQ5UEkvd0NpS1Zu?=
 =?utf-8?B?Tm9USC9rOFJjQU5MckFRdlVLeUM0eFk5UVo3TzJxMXBTd2NmZ3VwTktHR3pR?=
 =?utf-8?B?MkhIS3ZOY1AxUnQvWHYwRkM1TjZUK2ZOTmRzZnZaSEpTUUcyTHc3TGtSMkdY?=
 =?utf-8?B?Q1pYMkVnZ2l2LzdTZGR4Y1lTQSs4dUVpeUtMbUNSdS8zeVhRUjFvZ1kwbkhl?=
 =?utf-8?B?cE9KQmQ0cEJPNmc0TGhkbERUMjF0SUVyOFhoR2FWdFJFSEphYy9HdS94THhN?=
 =?utf-8?B?Sm1aVDhnMGpOK3gxaFF2WDNHSU5WeTZDOWEwODlLem9CWjJQK3RuQTEvVXNl?=
 =?utf-8?B?elRIWVZwY09HSHRRR2JiUXdKdlBGeHlOcDRKRUZVb3RiNDFnWFBoNzJ5SXla?=
 =?utf-8?B?ZzlJSzBYVkllSlJYTXI2bkhVKzJCdVB2a1JHWjEwT2lwMWtyZG1kZGhNMFZD?=
 =?utf-8?B?bE5TZFg1S0xEU2picUNlSUliTHpVeDRnSnBuNEtpQ2NzMFBKUVc4THFacFJB?=
 =?utf-8?B?bmlHclNkYVN5VTR2Z1pyaVZzS1hCbXJ5ZDV1OUROVjh4SWMrc0plUmgxaUNw?=
 =?utf-8?B?Unk1aWVkU0FMd3BoeVZLTFgrSk5FT1Z2Z3MxaGQ0OGJ6MTNuNXBLVDFwZ2ND?=
 =?utf-8?B?R09IMDEzcXZORllxcDBwMFdhWHFKL2hzS2VnQ05SeWMvUy95T1d5UVBKYkpn?=
 =?utf-8?B?WnFJU05HYVYxNTVLaTl6Tlk3V0RUVDVQR09tdHRteWpCRzYvQmZYWUh5ZU8z?=
 =?utf-8?B?QW83L0pzRWxFVDF1NDArY0drVXJ4VU5ObTh6aVV6anRQL1FoVEtWc1NkTHpZ?=
 =?utf-8?B?Wmc3N3FWNUZsWThiTHRyc1N1VHlaZ3RCSG1EQktRdnVhWmNsaC8wazkxTUpR?=
 =?utf-8?B?UXdteG1ua3NzeGxrdldETFRVVnNJeW9GaG54VGZnV2h3a0g5SkVRTmxRRFlh?=
 =?utf-8?B?TFR6cHN6RE1VZ2p6ZFFhNVRDSTdxeFpDU1ZiS2VtQkxybmVsTGxvWTdOT0NT?=
 =?utf-8?B?VjZkNUtpeDd5alAxYUthdXZsT0ZseHRKZm95OC9XMEpqRXB4dEM5bzlsYk94?=
 =?utf-8?B?czJTOVBzR0s2c1BFdzliZURkTWJyN2trM1ZpSGs3ejNkQUJEKzE0ck5TRHhv?=
 =?utf-8?Q?mtjO0nHEXnVX5D8CvYUNE7k=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TG1JdWMyeHg1dE1yZEdmaXBNYkdXdFhGUmxHbWlZWFVTM0xCbWVrU0FMcHp6?=
 =?utf-8?B?SlZqaUE1MmZ6QWtWaTdvaU0vd0tUS2lCNUVlbHlpZ1BHanFlT2JPVkI4WVNV?=
 =?utf-8?B?WkgybU1qaUZhUWZiNmRuNDJ5anJYQ3JoQStYVnF5NWVyQSszalBQdGhZaDBB?=
 =?utf-8?B?OGlZME5KQkZuOWp6K29QYnFDRkl4Qnp0R09PR2UvNW1RUWxMZGFCYVRjUkY3?=
 =?utf-8?B?a3NoNlJ0THFsWGdQODlPTEo1dmZaYTNGWTJoZkJCdE5iOVBneXlIdzk1M0ZL?=
 =?utf-8?B?ZFRzcEU2SmE3M245MWFadEMxbWc0QmtHL2FHREZsQmRBSWtnanlMb1FvMXF3?=
 =?utf-8?B?ckJCZUs1d2x3UVhuN01mMXhHNXhIODM0dW53ZDJxbmI4akYxcndrVFRRZUlr?=
 =?utf-8?B?NXdhUFVOMUVSMnR0R0hDYjhTdkc3dFZneVZGWHJJWi9MRWxPNjVuZlVCVW42?=
 =?utf-8?B?bGpOQnlveWN2UTBKNG9Ua2I0SnFuZENlNGNZZHhpeGRrY2JGKy82Y3VleTN1?=
 =?utf-8?B?TnQ1aXdjbnZ3K1JlYWJwNHpBQzdYb2lyZFNjWVM1SGNzcVpIWkw4bFptMXNI?=
 =?utf-8?B?eTVuNTUyM2JwaGpuOVRvZTFkWEJyK3lrQXhKdU80TGIvTy8yTVRLUjlBcXUy?=
 =?utf-8?B?Ny9aWkJTb1lmK2VzUWlVbnJDSHZXWUJod2FrQ3Z2V1NNQVd0b2pmZlFCeEtL?=
 =?utf-8?B?dy8zZm51TytES3lMSWRoTUZpSnZ5bGdYelI0K3FBTE5xVmtka0RVMXNneGtR?=
 =?utf-8?B?S3JpWTRLdUYrQmsvc1ZoWGFiTVlyK2xONStZTElWcDBhbnQrTmUzVTlhcjF1?=
 =?utf-8?B?L2JrcGpMTVE5RDhiVVdPU01uOGJUUitoSFBxeDA5NHd5N2Z1TU5zWVM3Vmpl?=
 =?utf-8?B?MW5LUGlzWUhVY3NQUkpGTWlDY2VzQXVJanFUWCtyZEg2WnJJT1ZLeWh4dVc0?=
 =?utf-8?B?ejQrVm5FK1BtZ1IrTVV6MGU1bXNYVSs3dXgvNlByN0pscy9GRkhWRkpkajJF?=
 =?utf-8?B?ejN0RmxVTVRIQVZwVkJjVWJ3NnpaNTdRQXBrNWVRMXUwRWF2SUNyUDIzamNY?=
 =?utf-8?B?RkxkS3pOMnlqNnpzK1dvRzJMNDNWWlRvUzhsSnF0b2MwM2k0K0FLRFkvaHIy?=
 =?utf-8?B?NS9wWHBkb1Y2SnhneFJRTDFydDNuRFZ1d0RoQXdPSm13aDBRUnd2VFFJdjdB?=
 =?utf-8?B?L2hpK0lwckE3YzhGbUhNZGJSVTZEV1JYYm1SdlJRZzJqc2VGbUYyOWN0L2c2?=
 =?utf-8?B?S2kra2FBcWxhSDk4d3pXWEpOT25nZzdlS3RDVVVTR3F6YTJVQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9847b45-33c2-4bc9-02f9-08daffa76ead
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 14:13:01.1585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDMNdbSqhXHjj+Tga6okWr3jq+KT09XJ9u2MPAOd6IZfDtD8C6SPMyNvB/EuAulc8mdAlXiJAhcTindClJvgEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5570
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_06,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260137
X-Proofpoint-ORIG-GUID: Nmlnj5ZbElPbLteRKk6QP2E9aWI2Quwq
X-Proofpoint-GUID: Nmlnj5ZbElPbLteRKk6QP2E9aWI2Quwq
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 25/01/2023 16:53, Jiri Olsa wrote:
> On Tue, Jan 24, 2023 at 01:45:31PM +0000, Alan Maguire wrote:
> 
> SNIP
> 
>>  	} else {
>>  		struct btf_encoder_state *state = zalloc(sizeof(*state));
>>  
>> @@ -898,10 +954,12 @@ static void btf_encoder__add_saved_func(const void *nodep, const VISIT which,
>>  	/* we can safely free encoder state since we visit each node once */
>>  	free(fn->priv);
>>  	fn->priv = NULL;
>> -	if (fn->proto.optimized_parms) {
>> +	if (fn->proto.optimized_parms || fn->proto.inconsistent_proto) {
>>  		if (encoder->verbose)
>> -			printf("skipping addition of '%s' due to optimized-out parameters\n",
>> -			       function__name(fn));
>> +			printf("skipping addition of '%s' due to %s\n",
>> +			       function__name(fn),
>> +			       fn->proto.optimized_parms ? "optimized-out parameters" :
>> +							   "multiple inconsistent function prototypes");
>>  	} else {
>>  		btf_encoder__add_func(encoder, fn);
>>  	}
>> @@ -1775,6 +1833,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>>  		 */
>>  		if (fn->declaration)
>>  			continue;
>> +		if (!fn->external)
>> +			save = true;
> 
> how about conflicts between static and global functions,
> I can see still few cases like:
> 
>   void __init msg_init(void)
>   static void msg_init(struct spi_message *m, struct spi_transfer *x,
>                        u8 *addr, size_t count, char *tx, char *rx)
> 
>   static inline void free_pgtable_page(u64 *pt)
>   void free_pgtable_page(void *vaddr)
> 
>   STATIC inline long INIT parse_header(u8 *input, long *skip, long in_len)
>   static struct tb_cfg_result parse_header(const struct ctl_pkg *pkg, u32 len,
>                                          enum tb_cfg_pkg_type type, u64 route)
>   static void __init parse_header(char *s)
> 
>

great catch; I hadn't thought of this at all. Looks like it is often
the case that the first function found will actually end up in BTF
currently, so sometimes we get the static, sometimes the non-static.
I'm seeing the same list as above.

> could we enable the check/save globaly?
>

I think we could, though at the additional cost of a larger tree
of functions. I can't see another way to handle it though right
now.

Alan

 
> jirka
> 
>>  		if (!ftype__has_arg_names(&fn->proto))
>>  			continue;
>>  		if (encoder->functions.cnt) {
>> @@ -1790,7 +1850,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>>  			if (func) {
>>  				if (func->generated)
>>  					continue;
>> -				func->generated = true;
>> +				if (!save)
>> +					func->generated = true;
>>  			} else if (encoder->functions.suffix_cnt) {
>>  				/* falling back to name.isra.0 match if no exact
>>  				 * match is found; only bother if we found any
>> diff --git a/dwarves.h b/dwarves.h
>> index 1ad1b3b..9b80262 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -830,6 +830,7 @@ struct ftype {
>>  	uint16_t	 nr_parms;
>>  	uint8_t		 unspec_parms:1; /* just one bit is needed */
>>  	uint8_t		 optimized_parms:1;
>> +	uint8_t		 inconsistent_proto:1;
>>  };
>>  
>>  static inline struct ftype *tag__ftype(const struct tag *tag)
>> -- 
>> 1.8.3.1
>>
